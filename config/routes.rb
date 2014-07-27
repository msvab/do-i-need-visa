DoINeedVisa::Application.routes.draw do

  root 'index#index'

  post '/' => 'index#search'

  scope '/admin' do
    get '/', to: redirect('/admin/visa_sources')

    resources :visa_sources
  end

end
