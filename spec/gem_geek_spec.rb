require 'spec_helper'

USERNAME = 'Tatsukochi'

describe GemGeek do

  let(:plays){GemGeek.get_plays(USERNAME)}

  it 'has a version number' do
    expect(GemGeek::VERSION).not_to be nil
  end
  
  it 'downloads user data appropriately' do
    expect(GemGeek.get_user(USERNAME)).not_to be nil
  end
  
  it 'returns null in case nothing is found' do
    expect(GemGeek.get_user('aksjhdoajsdkljqwhohasdalsh')).to be nil
  end
  
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
  end

  it "allows chaining of commands" do
    expect(plays.before_date(Date.today).game('Takenoko').empty?).to be false
  end

  it "doesn't fail when wrong parameters are passed to bgg_plays" do

  end
end
