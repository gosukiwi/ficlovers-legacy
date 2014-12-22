FactoryGirl.define do
  factory :notification do
    message 'You have a new private message from <a href="#">Mike</a>.'
    read false
    action '<a href="#">Read</a>'
    association :user
  end
end
