# frozen_string_literal: true

require "spec_helper"

RSpec.describe Contentful::Array, type: :model do
  let(:response_double) { double }


  describe "new" do
    context "when successful" do
      context "when lazy loaded" do
        it "creates a simple new array of given model", :vcr do
          array = Contentful::Array.new(Contentful.new({ "content_type": "recipe" }).entries, Recipe, lazy_loaded: true)

          expect(array.items).not_to be_empty
          expect(array.count).not_to be_zero
          expect(array.items.first.lazy_loaded).to eq(true)
          expect(array.items.first.photo.lazy_loaded).to eq(false)
          expect(array.items.first.list_of_tags.first.lazy_loaded).to eq(true)
        end
      end

      context "when not lazy loaded" do
        it "creates a new array with depth of given model", :vcr do
          array = Contentful::Array.new(Contentful.new({ "content_type": "recipe" }).entries, Recipe, lazy_loaded: false)

          expect(array.items).not_to be_empty
          expect(array.count).not_to be_zero
          expect(array.items.first.lazy_loaded).to eq(false)
          expect(array.items.first.photo.lazy_loaded).to eq(false)
          expect(array.items.first.list_of_tags.first.lazy_loaded).to eq(false)
        end
      end
    end

    context "when errored" do
      describe "invalid status" do
        before do
          allow(response_double).to receive(:success?).and_return(false)
        end
        it "raises InvalidStatus" do
          expect { Contentful::Array.new(response_double, Recipe, lazy_loaded: false) }.to raise_error(Contentful::Errors::InvalidStatus)
        end
      end
      describe "invalid body" do
        it "raises InvalidBody", :vcr do
          expect { Contentful::Array.new(Contentful.new.entry("NysGB8obcaQWmq0aQ6qkC"), Recipe, lazy_loaded: false) }.to raise_error(Contentful::Errors::InvalidBody)
        end
      end
    end
  end
end
