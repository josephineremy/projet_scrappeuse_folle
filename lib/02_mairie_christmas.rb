require 'nokogiri'
require 'open-uri'
require 'pry'
require 'json'

URL = "http://annuaire-des-mairies.com/val-d-oise.html"

page = Nokogiri::HTML(URI.open(URL))

cols = page.xpath("//td[@width='206']")

base_url = "http://annuaire-des-mairies.com"
url_avernes='http://annuaire-des-mairies.com/95/avernes.html'

def one_address
  page = Nokogiri::HTML(URI.open('http://annuaire-des-mairies.com/95/avernes.html'))
  section_two= page.css('section')[2]
  table = section_two.css('table')
  tbody=table.css('tbody')
  row= tbody.css('tr')[3]
  email = row.css('td')[1].text
  return email
end


def give_href_arr(cols)
  href_arr = []
  cols.each do |col|
    all_a = col.css('p > a')
    all_a.each do |a|
      href_arr << a["href"]
      # "Adding href : #{a["href"]} to the list."
    end
  end
  return href_arr
end


def city_address(url_list, b_url)
  city_email = []
  url_list.each do |url|
    new_url = b_url + url[1..-1]
    page = Nokogiri::HTML(URI.open(new_url))
    city = page.css('section')[1].css('h1').text[0..-7]
    section_two= page.css('section')[2]
    table = section_two.css('table')
    tbody=table.css('tbody')
    row= tbody.css('tr')[3]
    email = row.css('td')[1].text
    city_email << {"#{city}": email}
    # "Adding =====>>> #{city} : #{email}"
  end
  puts city_email
  return city_email
end


one_address
city_address(give_href_arr(cols), base_url)
