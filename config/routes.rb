Rails.application.routes.draw do
  mount Coverband::Reporters::Web.new, at: 'prod_coverage' if Rails.env == 'production'

  # Defines the root path route ("/")
  # root "articles#index"
end
