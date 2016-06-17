require './lib/db.rb'
require './lib/get_ranking.rb'

Keyword.all.each do |keyword|
  ranking_list = get_ranking(keyword.word)
  next if keyword.rankings.created_today != Ranking.none

  rankings = []
  ranking_list.each_with_index do |url, i|
    ranking = keyword.rankings.new
    ranking.rank = i + 1
    ranking.url  = url
    rankings << ranking
  end
  Ranking.import rankings
  puts "#{keyword.word}"
  # exit
  sleep 10
end
