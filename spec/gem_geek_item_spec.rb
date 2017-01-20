require 'spec_helper'

describe GemGeek do
  let(:username){'Tatsukochi'}
  let(:collection){GemGeek.get_collection(:username)}
  
  it 'sorts out cooperative and competitive games' do
      takenoko = GemGeek.get_item(70919)
      mechs = GemGeek.get_item(209010)
      expect(takenoko.is_cooperative).to_be false  
      expect(mechs.is_cooperative).to_be true  
  end
end
