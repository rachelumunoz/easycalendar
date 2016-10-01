FactoryGirl.define do
  factory :notification_receiver do
    notification
    association :receiver, factory: :client
  end
end