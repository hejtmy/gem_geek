module GemGeekInfo
    module InfoGetter
        def self.get_game_plays_info(plays, options)
            play_info = BGGInfoPlays.new(plays)
            play_info.analyse_game(options[:id])
        end
    end
end

require 'gem_geek/info/bgg_info_plays'
require 'gem_geek/bgg_getter'