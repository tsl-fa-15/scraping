require 'open-uri'
require 'nokogiri'


doc = Nokogiri::HTML(open("https://chicago.craigslist.org/search/apa"))
doc.css('.content .row').each do |row|
  title_link = row.css('.hdrlnk')
  title = title_link.text
  link = title_link.attr('href')
  datetime = row.css('time').attr('datetime')
  price = row.css('span.price')
  if price
    price = price.text.split('$')[1]
  end

  housing_info_array = row.css('span.housing').text.split(' ')
  if housing_info_array.any?
    if housing_info_array[1].include? 'br'
      bedrooms = housing_info_array[1].split('br').first
    elsif housing_info_array[1].include? 'ft'
      sq_footage = housing_info_array[1].split('ft2').first
    end
    if housing_info_array[3]
      sq_footage = housing_info_array[3].split('ft2').first
    end
  else
    bedrooms = ""
    sq_footage = ""
  end

  puts "title: #{title}"
  puts "link: #{link}"
  puts "datetime: #{datetime}"
  puts "price: #{price}"
  puts "bedrooms: #{bedrooms}"
  puts "square footage: #{sq_footage}"
  puts
  puts
end























