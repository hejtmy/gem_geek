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
            unique_locations = plays.unique_locations
            results[:locations] = {}
            unique_locations.each do |location|
                results[:locations][location] = analyse_location(location)
            end
            
            results
        end
        
        def analyse_game(game_id)
            plays = @plays.game_id(game_id)
            results = {}
            results[:plays_total] = plays.count
            this_year = Date.new(Date.today.year, 1, 1)
            results[:plays_this_year] = plays.after_date(this_year).count
            results[:plays_last_year] = plays.before_date(this_year).after_date(this_year.prev_year).count
            results
        end
        
        def analyse_player(name)
            plays = @plays.with_players(name)
            results = {}
            results[:plays_total] = plays.count
            wins = 0
            plays.plays.each {|play| wins +=1 if play.winners.include?(name)}
            results[:wins] = wins 
            results[:games] = {}
            unique_games = plays.unique_game_id
            unique_games.each do |game_id|
                results[:games][game_id] = analyse_game(game_id)
            end
            results
        end
        
        def analyse_location(location)
            plays = @plays.at_location(location)
            results = {}
            results[:plays_total] = plays.count
            this_year = Date.new(Date.today.year, 1, 1)
            results[:plays_this_year] = plays.after_date(this_year).count
            results[:plays_last_year] = plays.before_date(this_year).after_date(this_year.prev_year).count
            results
        end
        
        private
    end
end