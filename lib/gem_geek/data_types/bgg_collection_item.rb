#modified from https://github.com/AcceptableIce/board-game-gem/

module GemGeek
	class BGGCollectionItem < BGGBase

		attr_reader :id, :type, :name, :year_published, :image, :thumbnail, :num_players, :status, :num_plays

		def initialize(xml)
			@id = xml["objectid"].to_i
			@type = xml["subtype"]
			@name = get_string(xml, "name")
			@year_published = get_string(xml, "yearpublished")
			@image = get_string(xml, "image")
			@thumbnail = get_string(xml, "thumbnail")
			@num_players = get_string(xml, "numplayers")
			@status = {
				:own => get_boolean(xml, "status", "own"),
				:prev_owned => get_boolean(xml, "status", "prevowned"),
				:for_trade => get_boolean(xml, "status", "fortrade"),
				:want => get_boolean(xml, "status", "want"),
				:want_to_play => get_boolean(xml, "status", "wanttoplay"),
				:want_to_buy => get_boolean(xml, "status", "wanttobuy"),
				:wishlist => get_boolean(xml, "status", "wishlist"),
				:preordered => get_boolean(xml, "status", "preordered"),
				:wishlist_priority => get_integer(xml, "status", "wishlistpriority"),
				:last_modified => get_datetime(xml, "status", "lastmodified")
			}
			@num_plays = get_integer(xml, "numplays")
		end
		
		def in_collection
			!list_statuses.empty?
		end
		
		def list_statuses
			stat = @status.map{|key, value| key if value}
			stat.pop(2) #removes last modified and wishlist priority (not a boolean)
			stat.compact! #removes nils
		end
		
		def get_item(stats = true)
			GemGeek.get_item(@id, statistics: stats)
		end
	end
end