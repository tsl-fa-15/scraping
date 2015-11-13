require 'open-uri'
require 'nokogiri'


doc = Nokogiri::HTML(open("https://chicago.craigslist.org/search/apa"))
doc.css('.content .row .hdrlnk').each do |title_link|
  puts title_link.text
end
