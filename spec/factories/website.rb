FactoryBot.define do
  factory :website, class: Website do
    name { '朝日新聞' }
    url { 'asahi.com' }
  end
end
