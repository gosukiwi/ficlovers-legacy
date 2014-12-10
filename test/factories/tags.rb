FactoryGirl.define do
  factory :tag do
    name 'SomeSurname Kiba'
    context 'characters'

    factory :tag_active do
      status 'active'

      factory :tag_active_fandom do
        context 'fandoms'
      end
    end

    factory :tag_fandom do
      name 'Naruto Shippuden'
      context 'fandoms'
    end
  end
end
