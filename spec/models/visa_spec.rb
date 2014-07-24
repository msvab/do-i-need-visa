require 'rails_helper'

describe Visa do
  it 'has a valid factory' do
    expect(FactoryGirl.create(:visa)).to be_valid
  end

  it 'is invalid without a citizen' do
    expect(FactoryGirl.build(:visa, citizen: nil)).to_not be_valid
  end

  it 'is invalid with a citizen length other than 2' do
    expect(FactoryGirl.build(:visa, citizen: 'a')).to_not be_valid
    expect(FactoryGirl.build(:visa, citizen: 'aaa')).to_not be_valid
  end
end
