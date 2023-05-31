# frozen_string_literal: true

require "spec_helper"

RSpec.describe Contentful::Entry, type: :model do
  describe "new", :focus do
    let(:entry_response) { JSON.parse(File.read("#{Rails.root}/spec/responses/chef.json")) }

    context "when lazy loaded" do
      let!(:entry) { Contentful::Entry.new(entry_response, lazy_loaded: true) }
      it "loads only the link" do
        expect(entry.class).to eq(Contentful::Entry)
        expect(entry.link_id).not_to be_nil
        expect(entry.sys).not_to be_nil

        expect(entry.lazy_loaded).to eq(true)

        expect(entry.metadata).to be_nil
        expect(entry.fields).to be_nil
      end
    end

    context "when not lazy loaded" do
      let!(:entry) { Contentful::Entry.new(entry_response, lazy_loaded: false) }
      it "loads the link and the name", :vcr do
        expect(entry.class).to eq(Contentful::Entry)
        expect(entry.link_id).not_to be_nil
        expect(entry.sys).not_to be_nil

        expect(entry.lazy_loaded).to eq(false)

        expect(entry.metadata).to be_nil
        expect(entry.fields).not_to be_nil
      end
    end
  end

end
