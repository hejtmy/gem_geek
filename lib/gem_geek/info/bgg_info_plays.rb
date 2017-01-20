module GemGeekInfo
    class BGGInfoPlays
        attr_reader :plays
        
        def initialize(plays = nil)
            @plays = plays
        end
        
        def analyse
            results = {}
            results[:plays_total] = plays.count
            this_year = Date.new(Date.today.year, 1, 1)
            results[:plays_this_year] = plays.after_date(this_year).count
            results[:plays_last_year] = plays.before_date(this_year).after_date(this_year.prev_year).count
            unique_games = plays.unique_game_id
            results[:games] = {}
            unique_games.each do |game_id|
                results[:games][game_id] = analyse_game(game_id)
            end
            unique_players = plays.unique_players
            results[:players] = {}
            unique_players.each do |game_id|
                results[:players][player] = analyse_player(game_id)
            end
            results
        end
        
        def analyse_game(game_id)
            plays = @plays.game_id(game_id)
            results = {}
            results[:plays_total] = plays.count
            this_year = Date.new(Date.today.year, 1 ,1)
            results[:plays_this_year] = plays.after_date(this_year).count
            results[:plays_last_year] = plays.before_date(this_year).after_date(this_year.prev_year).count
            results
        end
        
        def analyse_player(name)
            plays = @plays.with_player(name)
            results[:plays_total] = plays.count
            results[:wins] = plays.each {|play| play}
            results
        end
        
        private
    end
end