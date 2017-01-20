module GemGeekInfo
    class BGGInfoPlays
        attr_reader :plays
        
        def initialize(plays = nil)
            @plays = plays
        end
        
        def analyse
        end
        
        def analyse_game(game_id)
            plays = @plays.game_id(game_id)
            results = {}
            results[:plays_total] = plays.count
            #this year
            this_year = Date.new(Date.today.year, 1 ,1)
            results[:plays_this_year] = plays.after_date(this_year).count
            results[:plays_last_year] = plays.before_date(this_year).after_date(this_year.prev_year).count
            results
        end
        
        private
    end
end