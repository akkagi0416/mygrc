require './lib/db.rb'

keywords = open('keyword.txt').each_line.map{|line| line.chomp }

keywords.each do |keyword|
  next if Keyword.find_by(word: keyword)

  Keyword.create(word: keyword)
  puts keyword
end
