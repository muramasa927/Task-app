#confing:utf-8

User.create!(name: "管理者",
             email: "sample@email.com",
             password: "password",
             password_confirmation: "password",
             admin: true)
             
30.times do |n|
  name = Faker::Name.name
  email = "sample-#{n+1}@email.com"
  password = "password"
  User.create!(name: name,
              email: email,
              password: password,
              password_confirmation: password)
  Task.create!(task_name: "挨拶",
              note: "こんにちは、#{User.find(n+1).name}です",
              user_id: n+1)
end