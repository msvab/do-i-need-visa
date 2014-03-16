DoINeedVisa::Application.routes.draw do

  root 'index#index'

  post '/' => 'index#search'

  get 'admin/sources' => 'visa_sources#view'
  post 'admin/sources' => 'visa_sources#add'
  get 'admin/sources/:id/delete' => 'visa_sources#delete'

end
