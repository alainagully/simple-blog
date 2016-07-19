# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

# 1.upto(10) do |x|
#   Category.create title: "Category #{x}"
# end

1.upto(100) do |x|
  Post.create(
    title: Faker::Lorem.sentence,
    body: Faker::Lorem.paragraph(20),
    user_id: 1)
end
