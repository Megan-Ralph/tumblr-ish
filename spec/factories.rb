FactoryBot.define do
  factory :user do
    email { Faker::Internet.email }
    password { "blahblah123" }
    password_confirmation { "blahblah123" }
  end

  factory :article do
    title { "Worlds best MMO!" }
    body { "Final Fantasy XIV because blah blah" }
    user_id { 1 }
  end

  factory :event do
    title { "Fan Fest!" }
    body { "Event body blah blah" }
    start_date { DateTime.now }
    end_date { DateTime.now + 4.hours }
    user_id { 1 }
  end
end
