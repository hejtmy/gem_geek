module GemGeek
    class BGGPlay < BGGBase
    	attr_reader :id, :date, :quantity, :length, :incomplete, :nowinstats, :location, 
    		:bg_name, :bg_id, :players, :comment
    		
		attr_accessor :bgg_item
		
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
		        @comment = get_comment(play_xml)
		        @bgg_item = nil
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
		        @comment = ""
		        @bgg_item = nil
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
		
		def get_comment(play_xml)
			comment_xml = play_xml.css('comments')
			comment_xml.empty? ? nil : comment_xml.text
		end
		
		def winners
			winners = []
			@players.each do |player|
				winners.push(player) if player.win
			end
			winners
		end
		
		def better_winners #this is because of BGG load
			wins = winners
			if game.is_cooperative #pushes everybody as a winner
				wins = @players if wins.length > 1
			end
			wins
		end
		
	    def has_players(names)
	    	players = @players.map {|p| p.name}
	    	# asserts non nil array
	    	(names - players).empty?
	    end
	    
	    def group_size
	    	@players.length 
	    end
		
		def game
			if @bgg_item.nil?
				@bgg_item = GemGeek.get_item(bg_id)
			end
			@bgg_item
		end
		
	    private
	    def parse_date(date_string)
	    	date_string.empty? ? nil : Date.strptime(date_string, "%Y-%m-%d")
	    end
    end
end