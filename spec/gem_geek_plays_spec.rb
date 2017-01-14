require 'spec_helper'

describe GemGeek do
    let!(:username){'Tatsukochi'}
    let!(:plays){GemGeek.get_plays(username)}
    
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
    
    it "doesn't fail when wrong parameters are passed to bgg_plays" do
    
    end
end
