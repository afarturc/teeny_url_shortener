FactoryBot.define do
  factory :link do
    name { nil }
    description { nil }
    original_url { FFaker::Internet.http_url }
    short_url { FFaker::Internet.http_url }
    password { nil }
    expired_at { nil }
    user
  end
end
