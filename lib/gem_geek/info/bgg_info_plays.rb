module GemGeekInfo
    class BGGInfoPlays
        attr_reader :plays
        
        def initialize(plays = nil)
            @plays = plays
        end
        
        def analyse(game_id)
            plays = @plays.game_id(game_id)
            plays_total = plays.
            
        end
        
        private
    end
end