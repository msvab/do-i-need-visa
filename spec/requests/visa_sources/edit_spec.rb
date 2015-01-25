require 'rails_helper'

def sign_in
  visit visa_sources_path
  expect(page).to have_content 'Sign in'

  fill_in 'session_email', with: user.email
  fill_in 'session_password', with: user.password
  click_button 'Sign in'
end

describe 'request: /admin/visa_sources/{id}/edit', type: :feature do

  let!(:user) { FactoryGirl.create(:user, email: 'admin@user.com', password: 'password') }
  let!(:visa_source) { FactoryGirl.create(:visa_source) }

  it 'shows edit form' do
    sign_in
    visit edit_visa_source_path(visa_source.id)

    expect(page).to have_field 'Name', with: visa_source.name
    expect(page).to have_field 'Country', with: visa_source.country
    expect(page).to have_field 'URL', with: visa_source.url
    expect(page).to have_field 'CSS Selector'
    expect(page).to have_field 'Page Hash', with: visa_source.page_hash
    expect(page).to have_field 'Visa required', checked: visa_source.visa_required
    expect(page).to have_field 'Visa on arrival', checked: visa_source.on_arrival
  end

  it 'lets you modify visa source' do
    new_name = 'super new name'

    sign_in
    visit edit_visa_source_path(visa_source.id)

    fill_in 'Name', with: new_name
    click_button 'Update Source'

    expect(page).to have_selector :css, 'h1', text: 'Visa Sources'
    expect(page).to have_content new_name
  end
end
