module GemGeek
    class BGGPlay < BGGBase
    	attr_reader :id, :data, :quantity, :length, :incomplete, :nowinstats, :location, :bg_name, :bg_id, :players
    	
		def initialize(play_xml = nil)
			if !play_xml.nil?
		        @id = play_xml['id'].to_i
		        @data = play_xml['date']
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
		
		def add_players(xml)
			@players = []
		    players_xml = xml.css('players > player')
		    players_xml.each {|player_xml| @players.push(BGGPlayer.new(player_xml))}
	    end
    end
end