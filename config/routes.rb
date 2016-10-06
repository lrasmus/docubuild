Rails.application.routes.draw do
  devise_for :users, :controllers => { registrations: 'registrations' }
  get 'home/index'
  get 'context/new' => 'contexts#new'

  resources :sections do
    member do
      post 'set_context'
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
    end
    collection do
      get 'select_clone'
      post 'clone'
    end
  end

  namespace :public do
    resources :documents
    resources :document_files
  end

  # You can have the root of your site routed with "root"
  root 'home#index'
end
