FactoryGirl.define do
  factory :reply do
    content "This is the reply text, it must be at least 50 characters long to be valid."
    user
    post
  end

end
