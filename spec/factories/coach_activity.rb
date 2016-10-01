FactoryGirl.define do
  factory :coach_activity do
    coach { create(:user, name: "Michelle") }
    activity { create(:activity) }
  end
end