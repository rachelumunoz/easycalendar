require 'rails_helper'

RSpec.describe Location, type: :model do
  let(:iceArena) { Location.create!(name: "IceBox", address: "123 Way St.") }

  context "creating a new Location" do
    
    it "creates a Child object" do
      expect(iceArena).to be_an_instance_of Location
    end

    it "has a name" do
      expect(iceArena.name).to eq("IceBox")
    end

    it "has an address" do
      expect(iceArena.address).to eq("123 Way St.")
    end
    
  end
end
