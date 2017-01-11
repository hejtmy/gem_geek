module GemGeek
	class BGGPlayer < BGGBase

		attr_reader :username, :userid, :name, :startposition, :color, :score, :new, :rating, :win
		#<player username="Tatsukochi" userid="406390" name="hejtmy" startposition="1" color="" score="" new="0" rating="0" win="0"/>
		#<player username="" userid="0" name="Bětka" startposition="2" color="" score="" new="0" rating="0" win="0"/>
		def initialize(player_xml)
			if !player_xml.nil?
				@userid = player_xml["userid"].to_i
				@username = player_xml["username"]
				@name = player_xml["name"]
				@startposition = player_xml["userid"].to_i
				@color = player_xml["color"]
				@score = player_xml["score"].to_i
				@new = player_xml["new"]  == "1"
				@rating = player_xml["rating"].to_i
				@win = player_xml["win"] == "1"
			else
				@userid = -1
				@username = ""
				@name = ""
				@startposition = -1
				@color = ""
				@score = -1
				@new = false
				@rating = -1
				@win = false
			end
		end
		
		def is_bgg_user?
			@userid != 0 ? true : false
		end
		
		def bgg_user
			BGGUser.new(@username)
		end
	end
end