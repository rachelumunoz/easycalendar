FactoryGirl.define do
  factory :appointment do
    coach_activity
    child
    location
    client
  end
end