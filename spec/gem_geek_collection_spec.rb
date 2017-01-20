require 'spec_helper'

describe GemGeek do
  let(:username){'Tatsukochi'}
  let(:collection){GemGeek.get_collection(:username)}
end
