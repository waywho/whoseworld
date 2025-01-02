# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)

[{
  name: 'Storychor',
  domain: 'storychor.com',
  nav_position: 'top',
  layout_style: 'multi_page',
  slug: 'storychor'
}, {
  name: 'WeiHsi Hu',
  domain: 'weihsihu.com',
  nav_position: :left,
  subtitle: 'conductor, tenor',
  layout_style: :one_page,
  slug: 'weihsihu'
}, {
  name: 'Logical Thinking',
  domain: 'logical-thinking.co.uk',
  nav_position: :top,
  layout_style: :multi_page,
  slug: 'logical_thinking'
}, {
  name: 'Berlin UnRehearsed Musicals',
  domain: 'berlinunrehearsedmusicals.com',
  nav_position: :top,
  layout_style: :multi_page,
  slug: 'burm'
}].each do |site|
  Site.upsert(site)
end
User.create!(email: 'admin@example.com', password: 'password', password_confirmation: 'password') if Rails.env.development?
