require 'spec_helper'

USERNAME = 'Tatsukochi'

describe GemGeek do

  it 'has a version number' do
    expect(GemGeek::VERSION).not_to be nil
  end
  
  it 'downloads user data appropriately' do
    expect(GemGeek.get_user(USERNAME)).not_to be nil
  end
  
  it 'returns null in case nothing is found' do
    expect(GemGeek.get_user('aksjhdoajsdkljqwhohasdalsh')).to be nil
  end
  
end
