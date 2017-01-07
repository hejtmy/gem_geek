#this module gets speficif classes of objects and converts them to readable Hashes or jsons

#modified from https://github.com/AcceptableIce/board-game-gem/

require 'json'
module GemGeek
	class BGGGetter
		def self.get_item(id, statistics = false, api = 2, options = {})
			options[:id] = id
			options[:stats] = statistics ? 1 : 0
			item = BGGItem.new(self.request_xml(api == 2 ? "thing" : "boardgame", options, api), api)
			item.id == 0 ? nil : item
		end

		def self.get_items(ids, statistics = false, api = 2, options = {})
			options[:id] = ids.join(",")
			options[:stats] = statistics ? 1 : 0
			item_list = []
			if api == 2
				path = "thing"
				element = "item"
			else
				path = "boardgame"
				element = "boardgame"
			end

			item_xml = BoardGameGem.request_xml(path, options, api)		
			item_xml.css(element).wrap("<item_data></item_data>")		
			item_xml.css("item_data").each do |item_data|
				item_list.push(BGGItem.new(item_data, api))
			end

			item_list
		end

		def self.get_family(id, options = {})
			options[:id] = id
			family = BGGFamily.new(BoardGameGem.request_xml("family", options))
			family.id == 0 ? nil : family
		end

		def self.get_user(username, options = {})
			options[:name] = username
			user = BGGUser.new(BoardGameGem.request_xml("user", options))
			user.id == 0 ? nil : user
		end

		def self.get_collection(username, options = {})
			options[:username] = username
			collection_xml = self.request_xml("collection", options)
			if collection_xml.css("error").length > 0
				nil
			else
				BGGCollection.new(collection_xml)
			end
		end

		def self.search(query, options = {})
			options[:query] = query
			xml = self.request_xml("search", options)
			{
				:total => xml.at_css("items")["total"].to_i,
				:items => xml.css("item").map { |x| BGGSearchResult.new(x) }
			}
		end
	end
end

require_relative 'data_types/bgg_base'
require_relative 'data_types/bgg_item'
require_relative 'data_types/bgg_family'
require_relative 'data_types/bgg_user'
require_relative 'data_types/bgg_collection'
require_relative 'data_types/bgg_collection_item'
require_relative 'data_types/bgg_search_result'