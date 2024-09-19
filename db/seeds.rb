# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

Admin.find_or_create_by!(email: "admin@example.com") do |admin|
  admin.password = "123456"
end

test1 = User.find_or_create_by!(email: "test1@example.com") do |user|
  user.name = "test1"
  user.introduction = "テスト1紹介文"
  user.account_id = "test1"
  user.password = "123456"
end

test2 = User.find_or_create_by!(email: "test2@example.com") do |user|
  user.name = "test2"
  user.introduction = "テスト2メッセージ"
  user.account_id = "test2"
  user.password = "123456"
end

Post.find_or_create_by!(body: "今日発売のゲーム楽しい！") do |post|
  post.user = test1
end

Post.find_or_create_by!(body: '本当にいいゲームだった…' << "\n" << 'エンディングでずっと泣いちゃってた…') do |post|
  post.user = test2
end