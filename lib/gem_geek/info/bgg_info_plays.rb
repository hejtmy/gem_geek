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
            unique_players.each do |name|
                results[:players][name] = analyse_player(name)
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
            plays = @plays.with_players(name)
            results[:plays_total] = plays.count
            wins = 0
            results[:wins] = plays.each {|play| wins +=1 if play.winners.include?(name)}
            results
        end
        
        private
    end
end