FactoryGirl.define do
  factory :client, class: User do
    name "Martha Ruth"
  end

  factory :coach, class: User do
    name "Michelle Kwan"
  end
end
