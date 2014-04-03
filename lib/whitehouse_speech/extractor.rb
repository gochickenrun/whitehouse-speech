require 'rubygems'
require 'bundler/setup'

require 'open-uri'

require 'nokogiri'


class WhitehouseSpeech
  attr_accessor :content
  
  def initialize(url_or_filename)
    speech_page = Nokogiri::HTML(open url_or_filename)
    @content = speech_page.css '#content'  # Seems to be in a div with the id=content
  end

  def meta_information
    @content.css('.information').text
  end

  def date
    @content.css('.information .date').text
  end
  
  def headlines
    [@content.css('h1').text, @content.css('h3').text]
  end

  def location
    @content.css('p.rtecenter').text
  end

  def time
    @content.css('p.rtecenter + p').text
  end

  def text
    possible_paragraphs = @content.css('p')
    #found_location = false
    found_start_time = false
    body_text = []

    possible_paragraphs.each do |para|
      # Search for the start time to indicate when the actual text
      # begins.
      if not found_start_time
        begin
          @time = DateTime.parse(para.text)
          found_start_time = true
        rescue ArgumentError
          next
        end
      else
        body_text.push para.text
      end
    end

    body_text
  end
end


if __FILE__ == $0
  speech = WhitehouseSpeech.new 'remarks-president-preparing-college'
end
