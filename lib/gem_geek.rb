module GemGeek

  # Your code goes here...
	def self.get_user(username, options = {})
		BGGGetter.get_user(username, options)
	end
end

require "gem_geek/version"
require 'gem_geek/bgg_api'
require 'gem_geek/bgg_getter'