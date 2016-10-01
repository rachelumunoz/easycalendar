require 'rails_helper'

RSpec.describe NotificationReceiver, type: :model do
 
  let(:notification_receiver) { create(:notification_receiver) }

  context "creating a new NotificationReceiver" do
    
    it "creates a NotificationReceiver object" do
      expect(notification_receiver).to be_an_instance_of NotificationReceiver
    end

    it "has a receiver association" do
      expect(notification_receiver.receiver).to be_an_instance_of User
    end

    it "has a notification association" do
      expect(notification_receiver.notification).to be_an_instance_of Notification
    end

  end
end
