DoINeedVisa::Application.routes.draw do

  root 'index#index'

  post '/' => 'index#search'

  scope '/admin' do
    resources :visa_sources
  end

end
