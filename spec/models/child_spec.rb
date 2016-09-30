require 'rails_helper'

RSpec.describe Child, type: :model do
  
  let(:child) { Child.new(name: "Babe Ruth", age:"9") }

  context "creating a new child" do
    
    it "creates a Child object" do
      expect(child).to be_an_instance_of Child
    end

    it "has a name" do
      expect(child.name).to eq("Babe Ruth")
    end
    
    it "has an age" do
      expect(child.age).to eq(9)
    end

  end
end
