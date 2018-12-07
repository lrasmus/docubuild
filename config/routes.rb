Rails.application.routes.draw do
  apipie
  devise_for :users, :controllers => { registrations: 'registrations' }
  get 'home/index'
  get 'context/new' => 'contexts#new'

  resources :sections do
    member do
      post 'set_context'
      patch 'template_sync'
      patch 'clone_sync'
    end
  end
  resources :folders
  resources :visibilities
  resources :statuses
  resources :document_files
  resources :documents do
    resources :document_files
    member do
      get 'template_sections'
      post 'add_sections_from_templates'
      get 'import_sections'
      get 'preview'
      post 'set_context'
      get 'export_html'
      get 'export_joomla'
      get 'export_oib'
      put 'reorder_sections'
      put 'break_template_link'
      put 'break_clone_link'
      put 'template_sync'
      put 'clone_sync'
    end
    collection do
      get 'select_clone'
      post 'clone'
    end
  end

  get 'public', to: redirect('/public/documents')

  namespace :public do
    resources :documents
    resources :document_files
  end

  # Set API response location
  #mount API::V1::Base, at: "/api"
  scope module: 'api' do
    scope module: 'v1' do
      post '/user_token', to: 'authentication#authenticate'  # Legacy - used by AGS
      post '/api/login', to: 'authentication#authenticate'
      get '/api/documents', to: 'documents#index'
      get '/api/documents/:id', to: 'documents#show'
      get '/api/infobuttonRequests/search', to: 'infobutton_requests#search'
    end
  end


  # You can have the root of your site routed with "root"
  root 'home#index'
end
