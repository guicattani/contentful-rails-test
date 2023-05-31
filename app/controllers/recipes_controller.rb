# frozen_string_literal: true
class RecipesController < ApplicationController
  def index; end

  def show
    @recipe = Recipe.find(permit_params["link_id"])
    return render(file: "#{Rails.root}/public/404.html", layout: false) if @recipe.nil?

    @recipe
  end

  private

  def permit_params
    params.permit(:link_id)
  end
end
