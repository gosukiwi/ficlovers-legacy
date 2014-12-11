FactoryGirl.define do
  factory :tag do
    sequence(:name) { |i| "Some Kiba#{i}" }
    context 'characters'

    factory :tag_active do
      status 'active'

      factory :tag_active_fandom do
        context 'fandoms'
      end
    end

    factory :tag_fandom do
      context 'fandoms'
    end
  end
end
