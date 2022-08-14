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
  slug: 'storychor',
  orientation: 'top',
  subtitle: nil,
  template_style: :multi_page
}, {
  name: 'WeiHsi Hu',
  domain: 'weihsihu.com',
  slug: 'weihsihu',
  orientation: 'left',
  subtitle: 'conductor, tenor',
  template_style: :one_page
}, {
  name: 'Logical Thinking',
  domain: 'logical-thinking.co.uk',
  slug: 'logical_thinking',
  orientation: 'top',
  sutbitle: nil,
  template_style: :multi_page
}, {
  name: 'Berlin UnRehearsed Musicals',
  domain: 'berlinunrehearsedmusicals.com',
  slug: 'berlin_unrehearsed_musicals',
  orientation: 'top',
  sutbitle: nil,
  template_style: :multi_page
}].each do |site|
  Site.create(site) unless Site.exists?(domain: site[:domain])
end
