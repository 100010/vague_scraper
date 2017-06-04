require 'nokogiri'
require 'httpclient'

require 'nokogiri'
require 'capybara'
require 'capybara/poltergeist'


module VagueScraper
  class Driver
    class << self
      def call(url)
        Capybara.register_driver :poltergeist do |app|
          Capybara::Poltergeist::Driver.new(app, { js_errors: false, timeout: 1000 })
        end
        Capybara.default_selector = :xpath
        session = Capybara::Session.new(:poltergeist)

        session.driver.headers = { 'User-Agent' => @user_agent }
        session.visit url
        Nokogiri::HTML(session.html).tap do
          session.driver.quit
        end
      end
    end
  end
end
