# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

many_users = [
    {username: "test1", password: "pw1", email: "test"},
    {username: "test2", password: "pw2", email: "test"}
]

many_users.each do |p|
    User.create!(p)
end
