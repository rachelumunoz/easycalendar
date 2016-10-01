require 'rails_helper'

RSpec.describe Appointment, type: :model do
  
  let(:lesson) { create(:appointment) }

  context "creating a new Appointment" do
    
    it "creates an Appointment object" do
      expect(lesson).to be_an_instance_of Appointment
    end

    it "has a child association" do
      expect(lesson.child).to be_an_instance_of Child
    end

    it "has a location association" do
      expect(lesson.location).to be_an_instance_of Location
    end

    it "has a client association" do
      expect(lesson.child.client).to be_an_instance_of User
    end

  end
end