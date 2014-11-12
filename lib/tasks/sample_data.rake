namespace :db do
  desc "Fill database with sample data"
  task populate: :environment do
    clean
    make_users
    make_json_note
    make_notes
  end
end

def clean
  if User.all.length > 0
    User.all[0..-1].each { |u| u.delete }
  end

  Note.all.delete_all
end

def make_users
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

def make_json_note
  user = User.first

  Note.create!(
    title: "JSON data",
    content: '{ "type": "bmc-ui", "data": {"kp":["決算会社","流通パートナー","電話会社のパートナー"],"ka":["ソフトウェア開発"],"kr":["ソフトウェア開発","ソフトウェア"],"vp":["無料のインターネットテレビ電話","電話への格安通話 (SKYPEOUT)"],"cr":["マスカスタマイゼーション"],"ch":["SKYPE.COM","ヘッドセットメーカーとのパートナーシップ"],"cs":["世界中のウェブユーザー","電話へ通話したい人"],"co":["ソフトウェア開発","クレーム対応"],"rs":["無料","プリペイドもしくは定額の SKYPEOUT","ハードウェア売上"]} }',
    user_id: user.id
  )
end

def make_notes
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
