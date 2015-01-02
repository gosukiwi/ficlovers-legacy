FactoryGirl.define do
  factory :notification do
    message 'You have a new private message from Mike.'
    read false
    action '<a href="#">Read</a>'
    association :user
  end
end
