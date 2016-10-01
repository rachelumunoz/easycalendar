require 'rails_helper'

RSpec.describe Activity, type: :model do
  
  let(:figure_skating) { create(:activity) }
  
  context "creating a new activity" do
    
    it "creates an Activity object" do
      expect(figure_skating).to be_an_instance_of Activity
    end

    # NEED TO MAKE THIS PASS
    # it "should have a coach (user) association" do
    #   expect(figure_skating.coaches).to eq(michelle_kwan) 
    # end

  end
end
