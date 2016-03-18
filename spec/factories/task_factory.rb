FactoryGirl.define do
  factory :task do
    name {FFaker::Lorem.phrase}
    # sequence(:name){|n| "#{n}@f" }
  end

  trait :in_the_future do
    start_date { 2.days.from_now }
  end

  trait :in_the_past do
    start_date { 2.days.ago }
  end
end