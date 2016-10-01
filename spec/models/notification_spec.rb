require 'rails_helper'

RSpec.describe Notification, type: :model do
 
  let(:notification) { create(:notification) }

   context "creating a new notification" do
    
    it "creates an Notification object" do
      expect(notification).to be_an_instance_of Notification
    end

    it "has an associated appointment" do
      expect(notification.appointment).to be_an_instance_of Appointment
    end
    
    it "has content" do
      expect(notification.content).to eq("Lesson Canceled")
    end

    # it "has an associated message" do
    #   expect(notification.message).to eq()
    # end   

  end
end
