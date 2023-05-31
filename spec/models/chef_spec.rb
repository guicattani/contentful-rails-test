# frozen_string_literal: true

require "spec_helper"

RSpec.describe Chef, type: :model do
  describe "new", :focus do
    let(:chef_response) { JSON.parse(File.read("#{Rails.root}/spec/responses/chef.json")) }

    context "when lazy loaded" do
      let!(:chef) { Chef.new(chef_response, lazy_loaded: true) }
      it "loads only the link" do
        expect(chef.class).to eq(Chef)
        expect(chef.name).to be_nil
        expect(chef.link_id).not_to be_nil
        expect(chef.sys).not_to be_nil

        expect(chef.lazy_loaded).to eq(true)

        expect(chef.metadata).to be_nil
        expect(chef.fields).to be_nil
      end
    end

    context "when not lazy loaded" do
      let!(:chef) { Chef.new(chef_response, lazy_loaded: false) }
      it "loads the link and the name", :vcr do
        expect(chef.class).to eq(Chef)
        expect(chef.name).not_to be_nil
        expect(chef.link_id).not_to be_nil
        expect(chef.sys).not_to be_nil

        expect(chef.lazy_loaded).to eq(false)

        expect(chef.metadata).to be_nil
        expect(chef.fields).not_to be_nil
      end
    end
  end

end
