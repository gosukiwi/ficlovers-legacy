FactoryGirl.define do
  factory :user do
    name 'Tiffany'
    email 'tiff_77@gmail.com'
    password 'some_random_password'

    factory :user_admin do
      role 'admin'
    end
  end
end
