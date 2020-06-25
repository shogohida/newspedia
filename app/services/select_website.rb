require 'json'
require 'open-uri'

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
