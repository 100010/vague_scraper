require "vague_scraper/version"
require "vague_scraper/scraper"
require "vague_scraper/driver"
require 'worker/slack_notifier'

module VagueScraper
  class NoSuchUrlError < StandardError; end
  class Base
    class << self
      def execute(args)
        VagueScraper::Scraper.execute args
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

      def parser html
        raise NoParserDefinedErr "You need to define #{self}#parser"
      end

      def handler result
        p result
      end

      def result
        self.class.attrs.map { |k| [k, self.send(k)]  }.to_h
      end
    end
  end
end
