FactoryGirl.define do
  factory :user do |f|
    sequence :name do |i|
      "user_#{i}"
    end
    sequence :active do |i|
      i.even? ? true : false
    end
    f.age 25
  end

  factory :blog do |f|
    f.url 'http://my.awesome.blog'
  end

  factory :article do |f|
    f.title 'Title'
    f.content 'My personal opinion'
  end
end
