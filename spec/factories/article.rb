FactoryBot.define do
  factory :article, class: Article do
    association :website
    name { 'Article' }
    content { '法務大臣逮捕' }
    url { 'asahi.com/1234' }
  end
end
