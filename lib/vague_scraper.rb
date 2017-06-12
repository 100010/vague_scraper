require "vague_scraper/version"
require "vague_scraper/scraper"
require "vague_scraper/driver"

module VagueScraper
  class NoSuchUrlError < StandardError; end
  class NoParserDefinedErr < StandardError; end
end
