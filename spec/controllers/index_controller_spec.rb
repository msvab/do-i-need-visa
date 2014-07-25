require 'rails_helper'

RSpec.describe IndexController, :type => :controller do

  describe 'GET #index' do
    it 'presets citizen based on request IP when displaying index' do
      @request.env['REMOTE_ADDR'] = '93.93.84.85'

      get :index

      expect(assigns(:visa).citizen).to eq 'GB'
    end
  end

  describe 'POST #search' do
    it 'returns new Visa object when citizen and country are the same' do
      post :search, visa: { country: 'GB', citizen: 'GB' }

      expect(assigns(:visa).citizen).to eq 'GB'
      expect(assigns(:searched)).to eq true
    end

    it 'returns new Visa object when citizen and country are the same' do
      visa = FactoryGirl.build(:visa, citizen: 'CZ')
      source = FactoryGirl.build(:visa_source, country: 'GB', visas: [visa])
      source.save!

      post :search, visa: { country: source.country, citizen: visa.citizen }

      expect(assigns(:visa)).to eq source
      expect(assigns(:searched)).to eq true
    end

    it 'returns nil when visa doesnt exist for given combination' do
      post :search, visa: { country: 'CZ', citizen: 'GB' }

      expect(assigns(:visa)).to be_nil
      expect(assigns(:searched)).to eq true
    end
  end
end
