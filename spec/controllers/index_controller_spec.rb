require 'rails_helper'

RSpec.describe IndexController, :type => :controller do

  describe 'GET #index' do
    it 'presets citizen based on request IP when displaying index' do
      @request.env['REMOTE_ADDR'] = '93.93.84.85'

      get :index

      expect(assigns(:search_form)[:citizen]).to eq 'GB'
    end
  end

  describe 'POST #search' do
    it 'returns new Visa object when citizen and country are the same' do
      post :search, search_form: { country: 'GB', citizen: 'GB' }

      expect(assigns(:search_form)[:citizen]).to eq 'GB'
      expect(assigns(:search_form)[:result]).to be_nil
      expect(assigns(:search_form)[:searched]).to eq true
    end

    it 'returns new Visa object when citizen and country are the same' do
      visa = FactoryGirl.build(:visa, citizen: 'CZ')
      source = FactoryGirl.build(:visa_source, country: 'GB', visas: [visa])
      source.save!

      post :search, search_form: { country: source.country, citizen: visa.citizen }

      expect(assigns(:search_form)[:result]).to eq source
      expect(assigns(:search_form)[:searched]).to eq true
    end

    it 'returns nil when visa doesnt exist for given combination' do
      post :search, search_form: { country: 'CZ', citizen: 'GB' }

      expect(assigns(:search_form)[:result]).to be_nil
      expect(assigns(:search_form)[:searched]).to eq true
    end
  end
end
