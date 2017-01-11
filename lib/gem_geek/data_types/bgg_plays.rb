module GemGeek
    class BGGPlays < BGGBase
    	attr_reader :plays, :ids
    	
		def initialize(xml = nil)
			@plays = []
			if xml != nil then add_plays(xml) end
		end
		
		def add_plays(plays_xml)
			plays_xml.css('play').each do |play_xml| #select all play elements under plays
				play = BGGPlay.new(play_xml)
				add(play)
			end
		end

		# Adds a new BGGPlay into the array
		def add(play)
			if play == nil then return end
			# checks if the play is already int he array
			if play_exists?(play.id)
				#shoudl note number of non added games
				puts 'play already included'
				return false
			end
			# if not
			@plays.push(play)
			return true
		end
		
		def play_exists?(id)
			@plays.each { |play| if play.id == id then return true end}
			return false
		end
		
		def remove(id)
			if id < 1
				puts 'selected play not in the array'
			end
			# gets the index

			#removes the index and the play
		end

		def game_name(name)
			select(:bg_name, name)
		end

		def game_id(id)
		end

		def with_player(name)
		end

		def between_dates
		end

		def after_date
		end

		def before_date
		end

		def at_location(name)
			select(:location, name)
		end

		def first()

		end

		def select(key, value)
			#converts key string to parameter
			# selects if
			selected = []
			plays_r = BGGPlays.new()
			@plays.each do |play|
				plays_r.add(play) if play.send(key) == value 
			end
			return plays_r
		end

    end
end