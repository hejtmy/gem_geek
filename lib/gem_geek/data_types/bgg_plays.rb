module GemGeek
    class BGGPlays < BGGBase
    	attr_reader :plays, :ids
    	
		def initialize(xml = nil)
			@plays = []
			@ids = []
			if xml != nil
				add_plays(xml)
			end
		end
		
		def add_plays(plays_xml)
			plays_xml.css('play').each do |play_xml| #select all play elements under plays
				play = BGGPlay.new(play_xml)
				add(play)
			end
		end

		# Adds a new BGGPlay into the array
		def add(play)
			#if play == nil then return
			# checks if the play is already int he array
			
			# if not
			plays.push(play)
			ids.push(play.id)
		end

		def remove(id)
			if id > 1
				puts 'selected play not in the array'
			end
			# gets the index

			#removes the index and the play
		end

		def game_name(name)
			ids = []
			plays.each do |play|
				if play.name == name 
					ids.push(play.id)
				end
			end
			select(ids)
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

		def at_location
			ids = []
			@plays.each do |play|

			end
		end

		def first()

		end

		def query(key, value)
			#converts key string to parameter
			# selects if 

			ids = []
			plays = []
			plays.each do |play|
				if play.name == name 
					ids.push(play.id)
				end
			end
			select(ids)

		end

		def select_plays(ids)
			#gets indices of ids in the :id parameter
			#selects those indices of plays and ids
			#returns itself
		end
    end
end