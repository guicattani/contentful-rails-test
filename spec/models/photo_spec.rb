# frozen_string_literal: true

require "spec_helper"

RSpec.describe Photo, type: :model do
  describe "new", :focus do
    let(:photo_response) { JSON.parse(File.read("#{Rails.root}/spec/responses/asset.json")) }
    let(:photo_lazy_loaded_response) { JSON.parse(File.read("#{Rails.root}/spec/responses/asset_lazy_loaded.json")) }

    context "when lazy loaded" do
      let!(:photo) { Photo.new(photo_response, lazy_loaded: true) }
      it "loads only the link" do
        expect(photo.class).to eq(Photo)
        expect(photo.link_id).not_to be_nil
        expect(photo.sys).not_to be_nil

        expect(photo.lazy_loaded).to eq(true)

        expect(photo.metadata).to be_nil
        expect(photo.fields).to be_nil
        expect(photo.title).to be_nil
        expect(photo.file).to be_nil
        expect(photo.url).to be_nil
        expect(photo.file_name).to be_nil
        expect(photo.content_type).to be_nil
      end
    end

    context "when not lazy loaded" do
      let!(:photo) { Photo.new(photo_lazy_loaded_response, lazy_loaded: false) }
      it "loads the link and the name", :vcr do
        expect(photo.class).to eq(Photo)
        expect(photo.link_id).not_to be_nil
        expect(photo.sys).not_to be_nil

        expect(photo.lazy_loaded).to eq(false)

        # casuality, but it is set
        expect(photo.metadata).to be_nil
        expect(photo.fields).not_to be_nil
        expect(photo.title).not_to be_nil
        expect(photo.file).not_to be_nil
        expect(photo.url).not_to be_nil
        expect(photo.file_name).not_to be_nil
        expect(photo.content_type).not_to be_nil
      end
    end
  end

end
