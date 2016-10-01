require 'rails_helper'

RSpec.describe Location, type: :model do

  let(:location) { create(:location) }

  context "creating a new Location" do
    
    it "creates a Location object" do
      expect(location).to be_an_instance_of Location
    end

    it "has a name" do
      expect(location.name).to eq("IceBox")
    end

    it "has an address" do
      expect(location.address).to eq("123 Way St.")
    end

    # NEED TO FIX
    # it "has an appointment association" do
    #   expect(location.appointments.first).to be_an_instance_of Appointment
    # end
    
  end
end
