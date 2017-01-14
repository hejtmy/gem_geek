#this module gets speficif classes of objects and converts them to readable Hashes or jsons

#modified from https://github.com/AcceptableIce/board-game-gem/

require 'json'
module GemGeek
	module BGGGetter
		def self.get_item(id, statistics = false, api = 2, options = {})
			options[:id] = id
			options[:stats] = statistics ? 1 : 0
			item_xml = self.request_xml(api == 2 ? "thing" : "boardgame", options, api)
			item = BGGItem.new(item_xml, api)
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

			item_xml = BGGAPI.request_xml(path, options, api)		
			item_xml.css(element).wrap("<item_data></item_data>")		
			item_xml.css("item_data").each do |item_data|
				item_list.push(BGGItem.new(item_data, api))
			end

			item_list
		end

		def self.get_family(id, options = {})
			options[:id] = id
			family = BGGFamily.new(BGGAPI.request_xml("family", options))
			family.id == 0 ? nil : family
		end

		def self.get_user(username, options = {})
			options[:name] = username
			user = BGGUser.new(BGGAPI.request_xml("user", options))
			user.id == 0 ? nil : user
		end

		def self.get_collection(username, options = {})
			options[:username] = username
			collection_xml = BGGAPI.request_xml("collection", options)
			if collection_xml.css("error").length > 0
				nil
			else
				BGGCollection.new(collection_xml)
			end
		end

		def self.search(query, options = {})
			options[:query] = query
			xml = BGGAPI.request_xml("search", options)
			{
				:total => xml.at_css("items")["total"].to_i,
				:items => xml.css("item").map { |x| BGGSearchResult.new(x) }
			}
		end
		
		def self.get_plays(username, options = {})
			options[:username] = username
			options[:page] = 0 
			# this gets a bit more complicated 
			# BGG allows only downloading games in bunch of 201, so we need to loop until we get all of it
			plays = BGGPlays.new()
			while true do
				options[:page] += 1
				plays_xml = BGGAPI.request_xml("plays", options)
				num_results = plays_xml.root.children.count
				puts num_results
				plays.add_plays(plays_xml)
				break if num_results < 201
			end
			plays
		end
	end
end

require 'gem_geek/bgg_api'

require 'gem_geek/data_types/bgg_base'
require 'gem_geek/data_types/bgg_base'
require 'gem_geek/data_types/bgg_item'
require 'gem_geek/data_types/bgg_family'
require 'gem_geek/data_types/bgg_user'
require 'gem_geek/data_types/bgg_collection'
require 'gem_geek/data_types/bgg_collection_item'
require 'gem_geek/data_types/bgg_search_result'
require 'gem_geek/data_types/bgg_play'
require 'gem_geek/data_types/bgg_plays'
require 'gem_geek/data_types/bgg_player'