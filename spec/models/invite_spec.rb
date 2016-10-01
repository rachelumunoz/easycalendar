require 'rails_helper'

RSpec.describe Invite, type: :model do
  
  let(:invite) { create(:invite) }

  context "creating a new invite" do
    
    it "creates an Invite object" do
      expect(invite).to be_an_instance_of Invite
    end

    it "has an associated client" do
      expect(invite.client).to be_an_instance_of User
    end
    
    it "has an associated coach_activity" do
      expect(invite.coach_activity).to be_an_instance_of CoachActivity
    end

    it "has an associated coach" do
      expect(invite.coach).to be_an_instance_of User
    end   

    it "has an associated activity" do
      expect(invite.activity).to be_an_instance_of Activity
    end 

  end
end
