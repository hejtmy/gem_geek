module GemGeek
    class BGGPlay < BGGBase
    	attr_reader :id, :data, :quantity, :length, :incomplete, :nowinstats, :location, :bg_name, :bg_id, :players
    	
		def initialize(xml = nil)
			if !xml.nil?
		        @id = xml['id'].to_i
		        @data = xml['date']
		        @quantity = xml['quantity'].to_i
		        @length = xml['length'].to_i
		        @incomplete = nil
		        @nowinstats = nil 
		        @location = xml['location']
		        @bg_name = get_string(xml, 'item', 'name')
		        @bg_id = get_integer(xml, 'item', 'objectid')
		        @players = add_players(xml)
			else
		        @id = -1
		        @data = "-----"
		        @quantity = 0
		        @length = 0
		        @incomplete = nil
		        @nowinstats = nil 
		        @location = ""
		        @bg_name = ""
		        @bg_id = 0
		        @players = {}
			end
		end
		
		def add_players(xml)
		    players = xml.css('players')
		    players.each do |player|
		        
		    end
		    players = {}
		end
    end
end