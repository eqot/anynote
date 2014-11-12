namespace :db do
  desc "Fill database with sample data"
  task populate: :environment do
    make_users
    make_notes
  end
end

def make_users
  if User.all.length > 0
    User.all[0..-1].each { |u| u.delete }
  end

  password = "password"

  User.create!(
    email: "eqobar@gmail.com",
    password: password
  )

  3.times do
    User.create!(
      email: Faker::Internet.email,
      password: password
    )
  end
end

def make_notes
  Note.all.delete_all

  User.all[0..3].each do |user|
    10.times do
      Note.create!(
        title: Faker::Lorem.sentence,
        content: Faker::Lorem.paragraph,
        user_id: user.id
      )
    end
  end
end
