require "spec_helper"
require 'pry'

RSpec.describe VagueScraper do
  it "has a version number" do
    expect(VagueScraper::VERSION).not_to be nil
  end

  it "does something useful" do
    expect(false).to eq(true)
  end
end
