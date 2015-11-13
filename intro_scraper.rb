require 'open-uri'
require 'nokogiri'
require 'csv'

CSV.open("results.csv", "w+") do |csv|
  csv << ["title", "link", "datetime", "price", "bedrooms", "square footage", "post body"]
end


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

  detail_page = Nokogiri::HTML(open("https://chicago.craigslist.org/#{link}"))
  post_body = detail_page.css("#postingbody").text

  puts "title: #{title}"
  puts "link: #{link}"
  puts "datetime: #{datetime}"
  puts "price: #{price}"
  puts "bedrooms: #{bedrooms}"
  puts "square footage: #{sq_footage}"
  puts "post body: #{post_body}"
  puts
  puts

  CSV.open("results.csv", "a+") do |csv|
    csv << [title, link, datetime, price, bedrooms, sq_footage, post_body]
  end
end























