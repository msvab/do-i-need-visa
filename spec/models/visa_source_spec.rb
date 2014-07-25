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

  it 'returns codes of all countries this visa source applies to' do
    gb = FactoryGirl.build(:visa, citizen: 'GB')
    cz = FactoryGirl.build(:visa, citizen: 'CZ')
    source = FactoryGirl.build(:visa_source, visas: [gb, cz])

    expect(source.visa_codes).to contain_exactly(gb.citizen, cz.citizen)
  end

  it 'creates new visas for new country codes' do
    source = FactoryGirl.build(:visa_source, visas: [])

    source.visa_codes = ['GB']

    expect(source.visa_codes).to contain_exactly 'GB'
  end

  it 'deletes visas that are not present in the new country codes during assignment' do
    gb = FactoryGirl.build(:visa, citizen: 'GB')
    cz = FactoryGirl.build(:visa, citizen: 'CZ')
    source = FactoryGirl.build(:visa_source, visas: [gb, cz])

    source.visa_codes = ['CZ']

    expect(source.visa_codes).to contain_exactly cz.citizen
  end
end
