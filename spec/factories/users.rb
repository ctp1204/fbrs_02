FactoryBot.define do
  factory :user do
    name {Faker::Name.name}
    email {Faker::Internet.email}
    address {"Kiet 81 PNX"}
    password {"1234567899"}
    password_confirmation {"1234567899"}
  end
end
