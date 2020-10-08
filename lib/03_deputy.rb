require 'nokogiri'
require 'open-uri'
require 'pry'

URL = "http://www2.assemblee-nationale.fr/deputes/liste/alphabetique"

page = Nokogiri::HTML(URI.open(URL))

base_url = "http://www2.assemblee-nationale.fr"

def one_address
  page = Nokogiri::HTML(URI.open('http://www2.assemblee-nationale.fr/deputes/fiche/OMC_PA1838'))
  deputy = page.xpath("//div[@class='titre-bandeau-bleu clearfix']/h1").text.split(" ")
  fname = deputy[1]
  lname = deputy[2]
  email_element =  page.xpath("//a[contains(text(), '@assemblee-nationale.fr')]")
  dep_email = email_element[1].text
  return dep_email
end

def href_list(page)
  href_arr = []
  ul_list = page.xpath("//div[@class='clearfix col-container']/ul[@class='col3']")
  ul_list.each do |li|
    all_a = li.css('a')
    all_a.each do |a|
      href_arr << a['href']
      # "Adding : #{a['href']} to the list for the deputy #{a.text}"
    end
  end
  return href_arr
end

def deputy_address(url_list, b_url)
  deputy = []
  url_list.each do |url|
    begin
      new_url = b_url + url
      page = Nokogiri::HTML(URI.open(new_url))
      deputy = page.xpath("//div[@class='titre-bandeau-bleu clearfix']/h1").text.split(" ")
      fname = deputy[1]
      lname = deputy[2]
      email_element =  page.xpath("//a[contains(text(), '@assemblee-nationale.fr')]")
      dep_email = email_element[1].text
      deputy << {first_name: fname, last_name: lname, email: dep_email}
      # "Adding =====>>> #{fname} #{lname} : #{dep_email} to the list"
      puts "#{fname} #{lname} : #{dep_email}"
    rescue StandardError => e
      puts e.message
    end
  end
  return deputy
end


one_address
deputy_address(href_list(page), base_url)
