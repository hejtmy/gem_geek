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
	
	def self.get_item(id, statistics = false, api = 2, options = {})
		BGGGetter.get_collection(id, statistics, api, options)
	end
	
	def self.get_plays(username, options = {})
		BGGGetter.get_plays(username, options)
	end
	
end

require 'gem_geek/bgg_getter'