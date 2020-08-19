# puts 'Deleting users...'
# User.destroy_all

# puts 'Creating users...'

# @test_user = User.create!(
#   name: 'test user',
#   email: 'test@gmail.com',
#   password: '123456'
# )


puts "Deleting likes..."
Like.destroy_all

puts "Deleting articles..."
Article.destroy_all

puts "Deleting websites..."
Website.destroy_all

puts "Creating websites..."
Website.create!(
  name: "The New York Times",
  url: "https://www.nytimes.com/",
  image: "ny_times.jpg",
  description: "The New York Times (sometimes abbreviated as the NYT and NYTimes) is an American newspaper based in New York City with worldwide influence and readership. Founded in 1851, the paper has won 130 Pulitzer Prizes, more than any other newspaper. The Times is ranked 18th in the world by circulation and 3rd in the U.S."
)

Website.create!(
  name: "News API",
  url: "https://newsapi.org/",
  image: "news_api.png",
  description: "Get breaking news headlines, and search for articles from news sources and blogs all over the web with our news API."
)

Website.create!(
  name: "Wikipedia",
  url: "https://www.wikipedia.org/",
  image: "wikipedia.jpg",
  description: "Wikipedia is a multilingual online encyclopedia created and maintained as an open collaboration project by a community of volunteer editors using a wiki-based editing system. It is the largest and most popular general reference work on the World Wide Web."
)

Website.create!(
  name: "COVID-19 Data",
  url: "https://coronavirus.jhu.edu/map.html",
  image: "covid.png",
  description: "Get data about COVID-19 of a particular country. Data is sourced from Johns Hopkins University Coronavirus Resource Center."
)
