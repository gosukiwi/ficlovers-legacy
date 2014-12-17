FactoryGirl.define do
  factory :post do
    title "My New Post"
    content "This is the post content, it doesn't have to be long but at least 50 characters."
    association :user
    association :forum
  end
end
