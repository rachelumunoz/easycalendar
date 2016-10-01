require 'rails_helper'

RSpec.describe ClientLocation, type: :model do

  let(:client_location) { create(:client_location) }

  context "creating a new ClientLocation" do
    
    it "creates a ClientLocation object" do
      expect(client_location).to be_an_instance_of ClientLocation
    end

    it "has a user association" do
      expect(client_location.client).to be_an_instance_of User
    end

    it "has a location association" do
      expect(client_location.location).to be_an_instance_of Location
    end

  end
end
