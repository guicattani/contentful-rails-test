# frozen_string_literal: true
Rails.application.routes.draw do
  mount Coverband::Reporters::Web.new, at: "prod_coverage" if Rails.env == "production"

  root "recipes#index"
  get  "/:link_id", to: "recipes#show"
end
