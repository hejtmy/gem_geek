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
		#selects games based on string of the name
		def game(name)
			raise ArgumentError, 'BGGPlays::game Argument is not string' unless name.is_a? String 

			#validates string
			name.to_s
			select(:bg_name, name)
		end

		def game_id(id)
			 raise ArgumentError, 'BGGPlays::game_id Argument is not integer' unless id.is_a? Integer 
		end

		def with_player(name)
			raise ArgumentError, 'BGGPlays::with_player Argument is not string' unless name.is_a? String

		end

		def with_user(username)
			raise ArgumentError, 'BGGPlays::with_user Argument is not string' unless username.is_a? String

		end

		def after_date(date)
			raise ArgumentError, 'BGGPlays::with_user Argument is not date' unless date.is_a? Date
			select(:date, date, :>)
		end

		def before_date(date)
			raise ArgumentError, 'BGGPlays::with_user Argument is not date' unless date.is_a? Date 
			select(:date, date, :<)
		end

		def at_location(name)
			raise ArgumentError, 'Argument is not string' unless name.is_a? String 
			select(:location, name)
		end

		def first()
			@plays.any? ? @plays[0] : nil
		end

		def empty?
			!@plays.any?
		end

		private 
		def select(key, value, operator = :==)
			#converts key string to parameter
			# selects if
			selected = []
			plays_r = BGGPlays.new()
			@plays.each do |play|
				param = play.send(key)
				if not param.nil? 
					plays_r.add(play) if param.send(operator, value) #weird syntax
				end
			end
			return plays_r
		end

    end
end