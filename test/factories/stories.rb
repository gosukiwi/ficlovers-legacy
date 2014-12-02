FactoryGirl.define do
  factory :story do
    title 'The little train that could'
    summary 'This story is about a train, for some reason the train was a story is about a train, for some reason the train was a little short'
    association :user
  end
end
