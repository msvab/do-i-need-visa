require 'rails_helper'

describe 'request: /', :type => :feature do
  it 'mocks you, when you submit same country in both dropdowns' do
    visit '/'

    within('form') do
      find('#search_form_citizen').find('option[value=cz]').select_option
      find('#search_form_country').find('option[value=cz]').select_option
    end

    click_button '?'
    expect(page).to have_content 'No, you really do not need a visa for your own country!'
  end
end
