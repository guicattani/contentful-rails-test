# frozen_string_literal: true
class RecipesController < ApplicationController
  def index
    @recipes = cached_recipes
    return render(file: "#{Rails.root}/public/404.html", layout: false) if @recipes.nil?

    @recipes
  end

  def show
    @recipe = cached_recipe
    return render(file: "#{Rails.root}/public/404.html", layout: false) if @recipe.nil?

    @recipe
  end

  private

  def permit_params
    params.permit(:link_id)
  end

  def cached_recipe
    Rails.cache.fetch("recipe/#{permit_params["link_id"]}", expires_in: 12.hours) do
      Recipe.find(permit_params["link_id"])
    end
  end

  def cached_recipes
    Rails.cache.fetch("recipes", expires_in: 12.hours) do
      Recipe.all
    end
  end
end
