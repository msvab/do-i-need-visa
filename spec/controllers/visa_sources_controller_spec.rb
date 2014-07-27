require 'rails_helper'

RSpec.describe VisaSourcesController, :type => :controller do

  describe 'GET #new' do
    it 'requires sign-in' do
      get :new

      expect(response).to redirect_to :sign_in
    end

    it 'puts new Visa in the page model' do
      sign_in
      get :new

      expect(assigns(:visa_source)).to eq VisaSource.new
      expect(response).to have_http_status :success
    end
  end
end
