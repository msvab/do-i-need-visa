require 'rails_helper'

describe 'request: /admin/visa_sources', type: :feature do

  let!(:user) { FactoryGirl.create(:user, email: 'admin@user.com', password: 'password') }
  let!(:visa_source) { FactoryGirl.create(:visa_source) }

  it 'displays visa sources in a list' do
    sign_in
    visit visa_sources_path

    expect(page).to have_content visa_source.name
  end

  def sign_in
    visit visa_sources_path
    expect(page).to have_content 'Sign in'

    fill_in 'session_email', with: user.email
    fill_in 'session_password', with: user.password
    click_button 'Sign in'
  end
end
