FactoryGirl.define do
  factory :message do
    notification
    association :sender, factory: :coach
    association :receiver, factory: :client
    content "Y"
  end
end