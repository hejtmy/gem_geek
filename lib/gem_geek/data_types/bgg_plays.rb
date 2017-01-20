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
		
		def select_first(num)
			raise ArgumentError, 'BGGPlays::select_first Argument is not integer' unless num.is_a? Integer
			return if num < 1
			@plays = @plays.first(num)
		end
		
		def play_exists?(id)
			@plays.each { |play| if play.id == id then return true end}
			return false
		end
		
		def remove(id)

		end
		
		def play_id(id)
			raise ArgumentError, 'BGGPlays::play_id Argument is not integer' unless id.is_a? Integer
			select(:id, id)
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
			 select(:bg_id, id)
		end
		
		def group_size(number)
			raise ArgumentError, 'BGGPlays::group_size Argument is not integer' unless number.is_a? Integer
			select(:group_size, number)
		end
		
		def with_players(names)
			names = [names] if names.is_a? String
			raise ArgumentError, 'BGGPlays::with_player Argument is not string' unless names.is_a? Array
			select_fun(:has_players, names)
		end

		def with_users(usernames)
			usernames = [usernames] if usernames.is_a? String
			raise ArgumentError, 'BGGPlays::with_user Argument is not string' unless usernames.is_a? String
			select_fun(:has_players, usernames)
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
			plays_r = BGGPlays.new()
			@plays.each do |play|
				param = play.send(key)
				if not param.nil? 
					plays_r.add(play) if param.send(operator, value) #weird syntax
				end
			end
			return plays_r
		end

		def select_fun(func, value)
			plays_r = BGGPlays.new()
			@plays.each do |play|
				plays_r.add(play) if play.send(func, value)
			end
			return plays_r
		end
    end
end