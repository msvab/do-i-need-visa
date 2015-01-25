require 'digest'
require 'open-uri'
require 'nokogiri'

class PageHash
  def self.calculate(url, css_selector)
    page = Nokogiri::HTML(open(url))
    result = page.css(css_selector)

    raise 'no element found with selector ' + css_selector if result.length == 0
    raise 'more than one element found with selector ' + css_selector if result.length > 1

    text = result.first.text
    Digest::MD5.hexdigest text
  end
end