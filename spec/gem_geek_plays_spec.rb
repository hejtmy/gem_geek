require 'spec_helper'

USERNAME = 'Tatsukochi'

describe GemGeek do

  let(:plays){GemGeek.get_plays(USERNAME)}

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
    expect(plays.num_players(2).empty?).to be false
  end

  it "allows chaining of commands" do
    expect(plays.before_date(Date.today).game('Takenoko').empty?).to be false
  end

  it "doesn't fail when wrong parameters are passed to bgg_plays" do

  end
end
