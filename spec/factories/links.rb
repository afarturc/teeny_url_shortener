FactoryBot.define do
  factory :link do
    name { FFaker::Lorem.word }
    description { FFaker::Lorem.sentence }
    original_url { FFaker::Internet.http_url }
    short_url { SecureRandom.alphanumeric(8) }
    user
  end
end
