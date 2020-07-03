# puts 'Deleting users...'
# User.destroy_all

# puts 'Creating users...'
# @shogo = User.create!(
#   name: 'Shogo',
#   email: 'shogo@gmail.com',
#   password: '123456'
# )

puts "Deleting articles..."
Article.destroy_all

puts "Deleting websites..."
Website.destroy_all

puts "Creating websites..."
Website.create!(
  name: "The New York Times",
  url: "https://www.nytimes.com/"
)

Website.create!(
  name: "Financial Times",
  url: "https://www.ft.com/"
)

Website.create!(
  name: "News API",
  url: "https://newsapi.org/"
)

Website.create!(
  name: "Wikipedia",
  url: "https://www.wikipedia.org/"
)

Website.create!(
  name: "COVID-19 Data",
  url: "https://coronavirus.jhu.edu/map.html"
)
