module GemGeek
  # Your code goes here...
	def self.get_user(username, options = {})
		BGGGetter.get_user(username, options)
	end
	
	def self.get_family(id, options = {})
		BGGGetter.get_family(id, options)
	end

	def self.get_collection(username, options = {})
		BGGGetter.get_collection(username, options)
	end
	
	def self.get_item(id, statistics = true, api = 2, options = {})
		BGGGetter.get_item(id, statistics, options, api)
	end
	
	def self.get_plays(username, options = {})
		BGGGetter.get_plays(username, options)
	end
	
	#basically just Oj dump, but removes any class names from the result
	def self.to_json(bgg_thing)
		json = JSON(Oj.dump(bgg_thing))
		json = Helpers.except_nested(json, '^o')
		json = Helpers.except_nested(json, '^O')
	end
	
	def self.to_oj_json(bgg_thing)
		JSON(Oj.dump(bgg_thing))
	end
	
	def self.from_oj_json(json_thing)
		Oj.load(JSON[json_thing])
	end
	
  def self.parse_date(date_string)
		date_string.empty? ? nil : Date.strptime(date_string, "%Y-%m-%d")
  end
	
end

require 'gem_geek/helpers'
require 'gem_geek/version'
require 'gem_geek/bgg_getter'
require 'gem_geek_info'