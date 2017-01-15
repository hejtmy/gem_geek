module GemGeek
    class BGGPlay < BGGBase
    	attr_reader :id, :date, :quantity, :length, :incomplete, :nowinstats, :location, :bg_name, :bg_id, :players
    	
		def initialize(play_xml = nil)
			if !play_xml.nil?
		        @id = play_xml['id'].to_i
		        @date = parse_date(play_xml['date'])
		        @quantity = play_xml['quantity'].to_i
		        @length = play_xml['length'].to_i
		        @incomplete = play_xml['incomplete'] == '1'
		        @nowinstats = play_xml['nowinstats'] == '1'
		        @location = play_xml['location']
		        @bg_name = get_string(play_xml, 'item', 'name')
		        @bg_id = get_integer(play_xml, 'item', 'objectid')
		        @players = add_players(play_xml)
			else
		        @id = -1
		        @data = "-----"
		        @quantity = 0
		        @length = 0
		        @incomplete = 0
		        @nowinstats = 0 
		        @location = ""
		        @bg_name = ""
		        @bg_id = 0
		        @players = []
			end
		end
		
		def add_players(play_xml)
			players = []
		    players_xml = play_xml.css('players > player')
		    players_xml.each do |player_xml| 
		    	player = BGGPlayer.new(player_xml)
		    	players.push(player)
		    end
		    @players = players
	    end
		
		def winners
			winners = []
			@players.each do |player|
				winners.push(player) if player.win
			end
			winners
		end
		
	    def has_players(names)
	    	players = @players.map {|p| p.name}
	    	# asserts non nil array
	    	(names - players).empty?
	    end
	    
	    def group_size()
	    	@players.length 
	    end

	    private
	    def parse_date(date_string)
	    	date_string.empty? ? nil : Date.strptime(date_string, "%Y-%m-%d")
	    end
    end
end