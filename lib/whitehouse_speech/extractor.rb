require 'rubygems'
require 'bundler/setup'

require 'open-uri'

require 'nokogiri'


module WhitehouseSpeech
  
  class Extractor
    attr_accessor :content
    attr_reader :filename
    
    def initialize(url_or_filename)
      speech_page = Nokogiri::HTML(open url_or_filename)
      @filename = url_or_filename
      @content = speech_page.css '#content'  # Seems to be in a div with the id=content
    end

    def meta_information
      @content.css('.information').text.lstrip.rstrip
    end

    def date
      unless @date
        date_string = @content.css('.information .date')
          .text.lstrip.rstrip
        begin
          @date = Date.parse date_string
        rescue ArgumentError
          throw "Invalid date for #{@filename}"
        end
      end
      
      @date
    end
    
    def headlines
      [@content.css('h1').text, @content.css('h3').text]
    end

    def location
      @content.css('p.rtecenter').text
    end

    def time
      # TODO: do validation on the time to see if this worked at all.
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
    
  end # class Extractor
  
end # module WhitehouseSpeech


if __FILE__ == $0
  speech = WhitehouseSpeech.new 'remarks-president-preparing-college'
end
