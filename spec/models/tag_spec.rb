# frozen_string_literal: true

require "spec_helper"

RSpec.describe Tag, type: :model do
  describe "new", :focus do
    let(:tag_response) { JSON.parse(File.read("#{Rails.root}/spec/responses/tag.json")) }

    context "when lazy loaded" do
      let!(:tag) { Tag.new(tag_response, lazy_loaded: true) }
      it "loads only the link" do
        expect(tag.class).to eq(Tag)
        expect(tag.name).to be_nil
        expect(tag.link_id).not_to be_nil
        expect(tag.sys).not_to be_nil

        expect(tag.lazy_loaded).to eq(true)

        expect(tag.metadata).to be_nil
        expect(tag.fields).to be_nil
      end
    end

    context "when not lazy loaded" do
      let!(:tag) { Tag.new(tag_response, lazy_loaded: false) }
      it "loads the link and the name", :vcr do
        expect(tag.class).to eq(Tag)
        expect(tag.name).not_to be_nil
        expect(tag.link_id).not_to be_nil
        expect(tag.sys).not_to be_nil

        expect(tag.lazy_loaded).to eq(false)

        expect(tag.metadata).to be_nil
        expect(tag.fields).not_to be_nil
      end
    end
  end

end
