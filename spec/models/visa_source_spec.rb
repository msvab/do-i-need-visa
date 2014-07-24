require 'rails_helper'

describe VisaSource do
  it 'has a valid factory' do
    expect(FactoryGirl.create(:visa_source)).to be_valid
  end

  it 'is invalid without a name' do
    expect(FactoryGirl.build(:visa_source, name: nil)).to_not be_valid
  end

  it 'is invalid without a country' do
    expect(FactoryGirl.build(:visa_source, country: nil)).to_not be_valid
  end

  it 'is invalid without a url' do
    expect(FactoryGirl.build(:visa_source, url: nil)).to_not be_valid
  end

  it 'is invalid without a description' do
    expect(FactoryGirl.build(:visa_source, description: nil)).to_not be_valid
  end

  it 'is invalid without an etag and last_modified' do
    expect(FactoryGirl.build(:visa_source, etag: nil, last_modified: nil)).to_not be_valid
  end

  it 'is invalid with a name longer than 255 characters' do
    expect(FactoryGirl.build(:visa_source, name: 'a' * 256 )).to_not be_valid
  end

  it 'is invalid with an url longer than 255 characters' do
    expect(FactoryGirl.build(:visa_source, url: 'a' * 256 )).to_not be_valid
  end

  it 'is invalid with an etag longer than 255 characters' do
    expect(FactoryGirl.build(:visa_source, etag: 'a' * 256 )).to_not be_valid
  end

  it 'is invalid with a country length other than 2' do
    expect(FactoryGirl.build(:visa_source, country: 'a')).to_not be_valid
    expect(FactoryGirl.build(:visa_source, country: 'aaa')).to_not be_valid
  end
end
