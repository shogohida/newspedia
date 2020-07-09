FactoryBot.define do
  factory :like, class: Like do
    association :article
    association :user
  end
end
