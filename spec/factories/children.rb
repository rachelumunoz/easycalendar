FactoryGirl.define do
  factory :child do
    first_name "Baby"
    last_name "Ruth"
    age 9
    client { create(:user) }
  end
end