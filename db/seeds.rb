User.create!(name:  "Le Quoc Cuong",
             email: "lqcuong.qt@gmail.com",
             password: "CTP971204",
             password_confirmation: "CTP971204",
             admin: true,
             activated: true,
             activated_at: Time.zone.now)

20.times do |n|
  name  = Faker::Name.name
  email = "example-#{n+1}@railstutorial.org"
  password = "password"
  User.create!(name:  name,
               email: email,
               password: password,
               password_confirmation: password,
               activated: true,
               activated_at: Time.zone.now)
end
