Rails.application.routes.draw do
  mount Coverband::Reporters::Web.new, at: 'prod_coverage' if Rails.env == 'production'

  # root "articles#index"
end
