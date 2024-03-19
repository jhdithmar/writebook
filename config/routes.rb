Rails.application.routes.draw do
  root "books#index"

  resources :books do
    resources :leaves
    resources :pages
    resources :sections
    resources :pictures
  end

  direct :leafable do |leaf, options|
    route_for "book_#{leaf.leafable_name}", leaf.book, leaf.leafable, options
  end

  direct :edit_leafable do |leaf, options|
    route_for "edit_book_#{leaf.leafable_name}", leaf.book, leaf.leafable, options
  end

  get "up" => "rails/health#show", as: :rails_health_check
  get "service-worker" => "rails/pwa#service_worker", as: :pwa_service_worker
  get "manifest" => "rails/pwa#manifest", as: :pwa_manifest
end
