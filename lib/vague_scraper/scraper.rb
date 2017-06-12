require 'nokogiri'
require 'parallel'

module VagueScraper
  class Scraper
    class << self
      def execute(args)
        if !args[:urls].nil?
          urls = args[:urls]

          Parallel.
            map_with_index(urls, in_threads: @concurrency || 1) do |url, id|
              puts "\e[34m[#{id + 1}] scraping: #{ url }\e[0m"

              scraper = self.new
              html = VagueScraper::Driver.call url

              scraper.parser html
              ({ url: url }).merge(scraper.result).tap do |result_hash|
                scraper.handler result_hash
              end
            end
        else
           raise 'You need pass an argument urls: or raw_htmls:'
        end
      end

      def attr_accessor(*attrs)
        @attrs ||= []
        @attrs.concat attrs
        super
      end

      def attrs
        @attrs || self.superclass.instance_eval("@attrs")
      end

      def concurrency(value)
        @concurrency = value
      end

    end

    def parser html
      raise  "You need to define #{self.class}#parser"
    end

    def handler result
      p result
    end

    def result
      self.class.attrs.map { |k| [k, self.send(k)]  }.to_h
    end
  end
end


# class WikipediaScraper < VagueScraper::Base
#   attr_accessor :title, :image_urls # attributes which you want to get

#   # You need to define 2 methods
#   # parser ... define how to parse attributes from html.
#   # handler ... define what to do with result which is come from parser.

#   def parser(html) # html is Nokogiri::HTML::Document object
#     @title      = html.css('title').text # Ruby - Wikipedia
#     @image_urls = html.css('img').map { |img| img[:src] } # ["//upload.wikimedia.org/wikipedia/commons/thumb/8/80/Ruby_-_Winza%2C_Tanzania.jpg/240px-Ruby_-_Winza%2C_Tanzania.jpg", ...]
#   end

#   def handler(result) # result is Hash which contain parsed attributes
#     p result
#   end
# end

# WikipediaScraper.execute urls: %w[https://en.wikipedia.org/wiki/Ruby]
