# require 'json'
# require 'open-uri'

# puts 'Deleting events...'
# Article.destroy_all

puts 'Deleting users...'
User.destroy_all

puts 'Creating users...'
@shogo = User.create!(
  name: 'Shogo',
  email: 'shogo@gmail.com',
  password: '123456'
)

# puts 'Creating articles...'
# Article.create!(
#   name: 'test',
#   user: @shogo
# )

# nytimes
# url1 = "https://api.nytimes.com/svc/search/v2/articlesearch.json?q=election&api-key=KWwSqakiTpXxhKaIS8211GJYbEeKgWCZ"
# ny_serialized = open(url1).read
# election_articles = JSON.parse(ny_serialized)
# election_articles["response"]["docs"].each do |article|
#   Event.create!(
#     name: "test",
#     user: @shogo,
#     content: article["lead_paragraph"]
#   )
# end

# # ft times
# url2 = "https://api.ft.com/content/notifications?apiKey=59cbaf20e3e06d3565778e7b7b9ba4f2d4ed4887b6861c77c7eda766&since=2020-06-12T13:50:00.000Z"
# ft_serialized = open(url2).read
# recent_articles = JSON.parse(ft_serialized)
# recent_articles["notifications"].each do |article|
#   Event.create!(
#     name: "test",
#     user: @shogo,
#     content: article["apiUrl"][0..7] + article["apiUrl"][12..-1]
#   )
# end
