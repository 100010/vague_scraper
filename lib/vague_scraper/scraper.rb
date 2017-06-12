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
