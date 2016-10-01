require 'rails_helper'

RSpec.describe User, type: :model do
  let(:michelle_kwan) { build(:user, name: 'Michelle') }

  context "creating a new user" do
  
    it "is an instance of User" do
      expect(michelle_kwan).to be_an_instance_of User
    end
  
    it "has a name" do
      expect(michelle_kwan.name).to eq("Michelle")
    end

  end
end
