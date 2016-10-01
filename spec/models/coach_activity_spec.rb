require 'rails_helper'

RSpec.describe CoachActivity, type: :model do
  
  let(:coach_activity) { create(:coach_activity) }

  context "creating a new CoachActivity" do
    
    it "creates a CoachActivity object" do
      expect(coach_activity).to be_an_instance_of CoachActivity
    end

    it "has a coach association" do
      expect(coach_activity.coach).to be_an_instance_of User
    end

    it "has an activity association" do
      expect(coach_activity.activity).to be_an_instance_of Activity
    end

  end
end
