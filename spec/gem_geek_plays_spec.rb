require 'spec_helper'

describe GemGeek do
    let!(:username){'Tatsukochi'}
    let(:get_plays){GemGeek.get_plays(username)}
    plays = GemGeek.get_plays('Tatsukochi')

    it "download games without issues" do
        expect(plays.first).not_to be nil
    end
    
    it "doesn't input game if it already exists" do
        expect(plays.add(plays.plays[1])).to be false
    end
    
    it "appropriately selects based on date" do
        expect(plays.after_date(Date.today.next_day).empty?).to be true
        expect(plays.before_date(Date.today).empty?).to be false
    end
    
    it "appropriately selects based on players" do
        expect(plays.group_size(2).empty?).to be false
        expect(plays.group_size(100).empty?).to be true
    end
    
    it "allows chaining of commands" do
        expect(plays.before_date(Date.today).game('Takenoko').empty?).to be false
    end
    
    it "selects a single game by play id" do
        expect(plays.play_id(21309136).plays.length).to be 1
    end
    
    it "doesn't fail when wrong parameters are passed to bgg_plays" do
    
    end
    
    it 'correctly deals with cooperative plays' do
        pandemic_plays = plays.game_id(161936)
        legendary_plays = plays.game_id(146652)
        pandemic_plays.plays.each do |play|
            [play.players.length, 0].should include play.winners.length
        end
        legendary_plays.plays.each do |play|
            [play.players.length, 0].should include play.winners.length
        end
    end
    it "donwloads correct number of plays" do
        plays_limited = GemGeek.get_plays(username, {max: 10})
        plays_extreme = GemGeek.get_plays(username, {max: 100000})
        plays_unlimited = GemGeek.get_plays(username, {max: 0})
        expect(plays_limited.plays.length).to be 10
        expect(plays_unlimited.plays.length).to be > 10
        expect(plays_extreme.plays.length).to be > 0
    end
end
