FactoryBot.define do
  factory :click do
    device_ip { FFaker::Internet.ip_v4_address }
    system { 'Desktop' }
    browser { 'Safari' }
    language { 'EN' }
    platform { 'Mac OS' }
    link
  end
end
