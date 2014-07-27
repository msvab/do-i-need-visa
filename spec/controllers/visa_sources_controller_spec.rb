require 'rails_helper'

RSpec.describe VisaSourcesController, :type => :controller do

  describe 'GET #new' do
    it 'requires sign-in' do
      get :new

      expect(response).to redirect_to :sign_in
    end

    it 'puts new VisaSource in the page model' do
      sign_in
      get :new

      expect(assigns(:visa_source)).to eq VisaSource.new
      expect(response).to have_http_status :success
    end
  end

  describe 'GET #edit' do
    it 'requires sign-in' do
      get :edit, id: 1

      expect(response).to redirect_to :sign_in
    end

    it 'puts existing VisaSource in the page model' do
      visa_source = FactoryGirl.create(:visa_source)

      sign_in
      get :edit, id: visa_source.id

      expect(assigns(:visa_source)).to eq visa_source
      expect(response).to have_http_status :success
    end
  end

  describe 'POST #create' do
    it 'requires sign-in' do
      post :create, visa_source: FactoryGirl.build(:visa_source)

      expect(response).to redirect_to :sign_in
    end

    it 'redirects to index page upon successful VisaSource creation' do
      visa_source = FactoryGirl.attributes_for(:visa_source)

      sign_in
      post :create, visa_source: visa_source

      expect(VisaSource.count).to be 1
      expect(VisaSource.all.first.country).to eq visa_source[:country]
      expect(response).to redirect_to action: :index
    end

    it 'creates visa sources with countries it applies to' do
      visa_codes = ['US', 'GB']
      visa_source = FactoryGirl.attributes_for(:visa_source, visa_codes: visa_codes)

      sign_in
      post :create, visa_source: visa_source

      expect(VisaSource.count).to be 1
      expect(VisaSource.all.first.country).to eq visa_source[:country]
      expect(VisaSource.all.first.visa_codes).to contain_exactly *visa_codes
    end

    it 'displays validation errors upon submitting invalid VisaSource' do
      visa_source = FactoryGirl.attributes_for(:visa_source, country: 'rubbish')

      sign_in
      post :create, visa_source: visa_source

      expect(VisaSource.count).to be 0
      expect(response).to render_template :new
      expect(flash[:errors]).to include :country
    end
  end

  describe 'POST #update' do
    it 'requires sign-in' do
      post :update, id: 1, visa_source: FactoryGirl.build(:visa_source)

      expect(response).to redirect_to :sign_in
    end

    it 'redirects to index page upon successful VisaSource update' do
      visa_codes = ['US']
      visa_source = FactoryGirl.create(:visa_source)
      updated_source = visa_source.attributes.merge({description: 'Hello!', visa_codes: visa_codes})

      sign_in
      post :update, id: visa_source.id, visa_source: updated_source

      expect(VisaSource.count).to be 1
      expect(VisaSource.all.first.country).to eq visa_source.country
      expect(VisaSource.all.first.description).to eq updated_source[:description]
      expect(VisaSource.all.first.visa_codes).to eq visa_codes
      expect(response).to redirect_to action: :index
    end

    it 'updates countries for which the visa sources applies' do
      visa_codes = ['US', 'GB']
      visa_source = FactoryGirl.create(:visa_source, visa_codes: ['GB', 'CZ'])
      updated_source = visa_source.attributes.merge({description: 'Hello!', visa_codes: visa_codes})

      sign_in
      post :update, id: visa_source.id, visa_source: updated_source

      expect(VisaSource.count).to be 1
      expect(VisaSource.all.first.country).to eq visa_source.country
      expect(VisaSource.all.first.description).to eq updated_source[:description]
      expect(VisaSource.all.first.visa_codes).to contain_exactly *visa_codes
      expect(response).to redirect_to action: :index
    end

    it 'displays validation errors upon submitting invalid VisaSource' do
      visa_source = FactoryGirl.create(:visa_source)
      updated_source = visa_source.attributes.merge({country: 'rubbish'})

      sign_in
      post :update, id: visa_source.id, visa_source: updated_source

      expect(VisaSource.count).to be 1
      expect(VisaSource.all.first.country).to eq visa_source.country
      expect(response).to render_template :edit
      expect(flash[:errors]).to include :country
    end
  end
end
