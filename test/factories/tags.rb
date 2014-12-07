FactoryGirl.define do
  factory :tag do
    name "Haruno Sakura"
    context :characters

    factory :tag_fandom do
      name "Naruto Shippuden"
      context :fandom
    end
  end

end
