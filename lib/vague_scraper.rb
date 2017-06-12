require "vague_scraper/version"
require "vague_scraper/scraper"
require "vague_scraper/driver"
require 'worker/slack_notifier'

module VagueScraper
  class NoSuchUrlError < StandardError; end
  class NoParserDefinedErr < StandardError; end
end
