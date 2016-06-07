require 'open-uri'
require 'nokogiri'
require 'cgi'


def get_ranking(word)
  url_base = 'https://www.google.co.jp/search?q=WORD&num=100'
  user_agent = 'Mozilla/5.0 (iPhone; CPU iPhone OS 9_1 like Mac OS X) AppleWebKit/601.1.46 (KHTML, like Gecko) Version/9.0 Mobile/13B143 Safari/601.1'

  url = url_base.sub(/WORD/, CGI.escape(word))
  # html = open(url, 'User-Agent' => user_agent).read
  doc = Nokogiri::HTML(open(url, 'User-Agent' => user_agent))
  links = []
  doc.css('#rso .g').each do |g|
    links << g.css('h3.r a').attr('href').value
  end
  links
end
