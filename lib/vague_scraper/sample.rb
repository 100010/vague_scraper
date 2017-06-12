
class WikipediaScraper < VagueScraper::Base
  attr_accessor :title, :image_urls # attributes which you want to get

  # You need to define 2 methods
  # parser ... define how to parse attributes from html.
  # handler ... define what to do with result which is come from parser.

  def parser(html) # html is Nokogiri::HTML::Document object
    @title      = html.css('title').text # Ruby - Wikipedia
    @image_urls = html.css('img').map { |img| img[:src] } # ["//upload.wikimedia.org/wikipedia/commons/thumb/8/80/Ruby_-_Winza%2C_Tanzania.jpg/240px-Ruby_-_Winza%2C_Tanzania.jpg", ...]
  end

  def handler(result) # result is Hash which contain parsed attributes
    p result
  end
end

WikipediaScraper.execute urls: %w[https://en.wikipedia.org/wiki/Ruby]