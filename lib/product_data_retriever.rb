require 'nokogiri'
require 'open-uri'

class ProductDataRetriever
  attr_accessor :url, :css_target
  def initialize(url, css_target)
    @url = url
    @css_target = css_target
  end

  def current_state
    doc = Nokogiri::HTML(open(@url))
    return doc.at_css(@css_target)
  end
end
