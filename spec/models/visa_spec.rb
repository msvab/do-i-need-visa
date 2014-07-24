require 'rails_helper'

describe Visa do
  it 'has a valid factory' do
    expect(FactoryGirl.create(:visa)).to be_valid
  end

  it 'is invalid without a citizen' do
    expect(FactoryGirl.build(:visa, citizen: nil)).to_not be_valid
  end
end
