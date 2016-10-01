FactoryGirl.define do
  factory :appointment do
    coach_activity { create(:coach_activity)}
    child { create(:child) }
    location { create(:location)}
    client { create(:user) }
  end
end