require 'rails_helper'

def select_countries(citizen, country)
  within('form') do
    find('#search_form_citizen').find("option[value=#{citizen.upcase}]").select_option
    find('#search_form_country').find("option[value=#{country.upcase}]").select_option
  end
end

describe 'request: /', type: :feature do
  it 'mocks you, when you submit same country in both dropdowns' do
    visit '/'

    select_countries('CZ', 'CZ')
    click_button '?'

    expect(page).to have_content 'No, you really do not need a visa for your own country!'
  end

  it 'tells you that we dont have data for unknown country combination' do
    visit '/'

    select_countries('CZ', 'GB')
    click_button '?'

    expect(page).to have_content 'Unfortunately we do not know.'
  end

  it 'tells you that you need visa to given country' do
    visa = FactoryGirl.build(:visa, citizen: 'CZ')
    source = FactoryGirl.create(:visa_source, country: 'US', visa_required: true, visas: [visa])

    visit '/'

    select_countries(visa.citizen, source.country)
    click_button '?'

    expect(page).to have_content 'Unfortunately you do need a visa!'
  end

  it 'tells you that you can get visa on arrival to given country' do
    visa = FactoryGirl.build(:visa, citizen: 'CZ')
    source = FactoryGirl.create(:visa_source, country: 'AU', visa_required: true, on_arrival: true, visas: [visa])

    visit '/'

    select_countries(visa.citizen, source.country)
    click_button '?'

    expect(page).to have_content 'Unfortunately you do need a visa!'
    expect(page).to have_content 'But you can get it on arrival.'
  end

  it 'tells you that you dont need a visa to given country' do
    visa = FactoryGirl.build(:visa, citizen: 'CZ')
    source = FactoryGirl.create(:visa_source, country: 'DE', visa_required: false, visas: [visa])

    visit '/'

    select_countries(visa.citizen, source.country)
    click_button '?'

    expect(page).to have_content 'Luckily you do not need visa!'
  end
end
