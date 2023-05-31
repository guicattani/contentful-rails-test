# frozen_string_literal: true

require "spec_helper"

RSpec.describe Contentful, type: :model do
  describe "new" do
    it "creates a new Contentful class with default parameters" do
      contentful = Contentful.new
      expect(contentful.class).to eq(Contentful)
      expect(contentful.query).to be_nil
      expect(contentful.page).to eq(1)
    end

    it "creates a new Contentful class with query parameters" do
      contentful = Contentful.new({query: "something"})
      expect(contentful.class).to eq(Contentful)
      expect(contentful.query).not_to be_nil
    end

    it "creates a new Contentful class with query parameters" do
      contentful = Contentful.new({query: "something"}, 2)
      expect(contentful.class).to eq(Contentful)
      expect(contentful.page).to eq(2)
    end
  end

  describe "entries" do
    it "list all possible entries for contentful space and environment", :vcr do
      response = Contentful.new.entries
      expect(response).not_to be_nil
      expect(response.success?).to eq(true)
      expect(response["sys"]["type"]).to eq("Array")
      expect(response["total"]).to eq(28)
    end
  end

  describe "asset" do
    it "returns a given asset for contentful space and environment", :vcr do
      response = Contentful.new.asset("5mFyTozvSoyE0Mqseoos86")
      expect(response).not_to be_nil
      expect(response.success?).to eq(true)
      expect(response["sys"]["type"]).to eq("Asset")
      expect(response["fields"]["title"]).to be_present
      expect(response["fields"]["file"]["url"]).to be_present
    end
  end

  describe "asset" do
    it "returns a given entry for contentful space and environment", :vcr do
      response = Contentful.new.entry("NysGB8obcaQWmq0aQ6qkC")
      expect(response).not_to be_nil
      expect(response.success?).to eq(true)
      expect(response["sys"]["type"]).to eq("Entry")
      expect(response["fields"]["name"]).to be_present
    end
  end
end
