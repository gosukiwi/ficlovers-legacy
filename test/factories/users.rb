FactoryGirl.define do
  factory :user do
    sequence(:name) { |i| "Tiffany_#{i}" }
    sequence(:email) { |i| "tiff_#{i}@gmail.com" }
    password 'some_random_password'

    factory :user_admin do
      role 'admin'
    end
  end
end
