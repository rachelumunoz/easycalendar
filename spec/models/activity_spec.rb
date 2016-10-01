require 'rails_helper'

RSpec.describe Activity, type: :model do
  
  let(:activity) { create(:activity) }
  # let(:coach_activity) { create(:coach_activity, activity: :activity)}
  
  context "creating a new activity" do
    
    it "creates an Activity object" do
      expect(activity).to be_an_instance_of Activity
    end

    # NEED HELP WITH THIS ONE
    # it "has a coach (user) association" do
    #   expect(activity.coach_activities).to be_an_instance_of User
    # end

  end
end
