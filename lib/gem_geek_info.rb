module GemGeekInfo
    def self.game_plays_info(plays, options = {})
        InfoGetter.get_game_plays_info(plays, options)
    end
    
    def self.plays_info(plays, options = {})
        InfoGetter.get_plays_info(plays, options)
    end
    
    def self.player_info(plays, options = {})
        InfoGetter.get_player_plays_info(plays, options)
    end
    
    def self.location_info(plays, options = {})
        InfoGetter.get_player_plays_info(plays, options)
    end
end

require 'gem_geek/info_getter'
