require 'spec_helper'

describe GemGeekInfo do
    let(:username){'Tatsukochi'}
    plays = GemGeek.get_plays('Tatsukochi', {max: 70})
    it 'returns something' do
        expect(GemGeekInfo.plays_info(plays)).not_to be nil
    end
end
