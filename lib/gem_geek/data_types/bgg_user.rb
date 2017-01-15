#modified from https://github.com/AcceptableIce/board-game-gem/

module GemGeek
	class BGGUser < BGGBase

		attr_reader :id, :name, :avatar, :year_registered, :last_login, :state, :trade_rating, :first_name, :last_name

		def initialize(xml)
			if !xml.nil?
				@id = get_integer(xml, "user", "id")
				@name = get_string(xml, "user", "name")
				@first_name = get_string(xml, "firstname", "value")
				@last_name = get_string(xml, "lastname", "value")
				@avatar = get_string(xml, "avatarlink", "value")
				@year_registered = get_integer(xml, "yearregistered", "value")
				@last_login = get_string(xml, "lastlogin", "value")
				@state = get_string(xml, "stateorprovince", "value")
				@trade_rating = get_integer(xml, "traderating", "value")
			else
				@id = -1
				@first_name = ""
				@last_name = ""
				@name = ""
				@avatar = ""
				@year_registered = -1
				@last_login = "0000-00-00 00:00:00"
				@state = ""
				@trade_rating = -1
			end
		end
		
		def full_name
			if not (self.first_name.empty? && self.last_name.empty?)
				self.first_name + " " + self.last_name
			end
		end
		
		def get_collection
			return BGGGetter.get_collection(@name)
		end
	end
end