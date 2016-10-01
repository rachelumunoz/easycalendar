require 'rails_helper'

RSpec.describe Message, type: :model do

  let(:message) { create(:message) }

   context "creating a new Message" do
    
    it "creates an Message object" do
      expect(message).to be_an_instance_of Message
    end

    it "has an associated notification" do
      expect(message.notification).to be_an_instance_of Notification
    end
    
    it "has an associated sender" do
      expect(message.sender).to be_an_instance_of User
    end

    it "has an associated receiver" do
      expect(message.receiver).to be_an_instance_of User
    end

    it "has an associated appointment" do
      expect(message.appointment).to be_an_instance_of Appointment
    end

    it "has content" do
      expect(message.content).to eq("Y")
    end

  end
end
