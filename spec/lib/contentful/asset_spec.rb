# frozen_string_literal: true

require "spec_helper"

RSpec.describe Contentful::Asset, type: :model do
  describe "new", :focus do
    let(:asset_response) { JSON.parse(File.read("#{Rails.root}/spec/responses/asset.json")) }
    let(:asset_lazy_loaded_response) { JSON.parse(File.read("#{Rails.root}/spec/responses/asset_lazy_loaded.json")) }

    context "when lazy loaded" do
      let!(:asset) { Contentful::Asset.new(asset_response, lazy_loaded: true) }
      it "loads only the link" do
        expect(asset.class).to eq(Contentful::Asset)
        expect(asset.link_id).not_to be_nil
        expect(asset.sys).not_to be_nil

        expect(asset.lazy_loaded).to eq(true)

        expect(asset.metadata).to be_nil
        expect(asset.fields).to be_nil
        expect(asset.title).to be_nil
        expect(asset.file).to be_nil
        expect(asset.url).to be_nil
        expect(asset.file_name).to be_nil
        expect(asset.content_type).to be_nil
      end
    end

    context "when not lazy loaded" do
      let!(:asset) { Contentful::Asset.new(asset_lazy_loaded_response, lazy_loaded: false) }
      it "loads the link and the name", :vcr do
        expect(asset.class).to eq(Contentful::Asset)
        expect(asset.link_id).not_to be_nil
        expect(asset.sys).not_to be_nil

        expect(asset.lazy_loaded).to eq(false)

        # casuality, but it is set
        expect(asset.metadata).to be_nil
        expect(asset.fields).not_to be_nil
        expect(asset.title).not_to be_nil
        expect(asset.file).not_to be_nil
        expect(asset.url).not_to be_nil
        expect(asset.file_name).not_to be_nil
        expect(asset.content_type).not_to be_nil
      end
    end
  end

end
