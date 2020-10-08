require 'nokogiri'
require 'open-uri'
require 'pry'


MY_URL = "https://coinmarketcap.com/all/views/all/"


def create_arr(url)
  arr = []
  page = Nokogiri::HTML(open(url))
  rows = page.css('table').css('tr')
  rows.each do |row|
    begin
      symb = row.css('td')[2].text
      price = row.css('td')[4].text
      arr << {"#{symb}": price}
    rescue StandardError => e
      puts e.message
    end
  end
  return arr
end

def display_arr(arr)
  arr.each do |hash|
    puts "#{hash}"
  end
end

def perform(url)
  arr = create_arr(url)
  display_arr(arr)
end

perform(MY_URL)
