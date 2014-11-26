FactoryGirl.define do
  factory :chapter do
    title 'First chapter: A little story'
    content 'This is the content, it must be at least 150 characters or validations will complain! Lorem ipsum dolor sit amet. This is the content, it must be at least 150 characters or validations will complain! Lorem ipsum dolor sit amet.'
    association :story
  end
end
