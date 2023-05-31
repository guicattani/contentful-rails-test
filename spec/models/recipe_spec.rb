# frozen_string_literal: true

require "spec_helper"

RSpec.describe Recipe, type: :model do
  describe "abstract methods" do
    describe "self.all" do
      it "returns all recipes", :vcr do
        all = Recipe.all
        expect(all.class).to eq(Contentful::Array)
        expect(all.items.count).not_to eq(0)
      end
    end

    describe "self.find" do
      it "returns a recipe", :vcr do
        recipe = Recipe.find("437eO3ORCME46i02SeCW46")
        expect(recipe.class).to eq(Recipe)
        expect(recipe.title).not_to be_nil
        expect(recipe.photo).not_to be_nil
        expect(recipe.calories).not_to be_nil
        expect(recipe.description).not_to be_nil
        expect(recipe.list_of_tags).not_to be_nil
        expect(recipe.lazy_loaded).to eq(false)
        expect(recipe.link_id).not_to be_nil
        expect(recipe.metadata).to be_nil
        expect(recipe.sys).not_to be_nil
        expect(recipe.fields).not_to be_nil
      end
    end
  end

  describe "new", :focus do
    let(:recipe_response) { JSON.parse(File.read("#{Rails.root}/spec/responses/recipe.json")) }

    context "when lazy loaded" do
      let!(:recipe) { Recipe.new(recipe_response, lazy_loaded: true) }
      it "loads only immediate dependencies and photo", :vcr do
        expect(recipe.class).to eq(Recipe)
        expect(recipe.title).not_to be_nil
        expect(recipe.photo).not_to be_nil
        expect(recipe.calories).not_to be_nil
        expect(recipe.description).not_to be_nil
        expect(recipe.list_of_tags).not_to be_nil
        expect(recipe.link_id).not_to be_nil
        expect(recipe.sys).not_to be_nil

        expect(recipe.lazy_loaded).to eq(true)

        expect(recipe.photo.lazy_loaded).to eq(false)
        expect(recipe.photo.file).not_to be_nil
        expect(recipe.photo.file["url"]).not_to be_nil

        expect(recipe.list_of_tags.first.lazy_loaded).to eq(true)
        expect(recipe.chef.lazy_loaded).to eq(true)

        expect(recipe.metadata).to be_nil
        expect(recipe.fields).to be_nil
      end
    end

    context "when not lazy loaded" do
      let!(:recipe) { Recipe.new(recipe_response, lazy_loaded: false) }
      it "loads only immediate dependencies and photo", :vcr do
        expect(recipe.class).to eq(Recipe)
        expect(recipe.title).not_to be_nil
        expect(recipe.photo).not_to be_nil
        expect(recipe.calories).not_to be_nil
        expect(recipe.description).not_to be_nil
        expect(recipe.list_of_tags).not_to be_nil
        expect(recipe.link_id).not_to be_nil
        expect(recipe.sys).not_to be_nil

        expect(recipe.lazy_loaded).to eq(false)

        expect(recipe.photo.lazy_loaded).to eq(false)
        expect(recipe.photo.file).not_to be_nil
        expect(recipe.photo.file["url"]).not_to be_nil

        expect(recipe.list_of_tags.first.lazy_loaded).to eq(false)
        expect(recipe.list_of_tags.first.name).not_to be_nil
        expect(recipe.chef.lazy_loaded).to eq(false)

        # casuality, but it is set
        expect(recipe.metadata).to be_nil
        expect(recipe.fields).not_to be_nil
      end
    end
  end

end
