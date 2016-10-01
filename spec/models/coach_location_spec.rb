require 'rails_helper'

RSpec.describe CoachLocation, type: :model do
  
  let(:coach_location) { create(:coach_location) }

  context "creating a new CoachLocation" do
    
    it "creates a CoachLocation object" do
      expect(coach_location).to be_an_instance_of CoachLocation
    end

    it "has a user association" do
      expect(coach_location.coach).to be_an_instance_of User
    end

    it "has a location association" do
      expect(coach_location.location).to be_an_instance_of Location
    end

  end
end
