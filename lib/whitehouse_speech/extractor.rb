require 'rubygems'
require 'bundler/setup'

require 'open-uri'

require 'nokogiri'


module WhitehouseSpeech

  class Extractor
    attr_accessor :content
    attr_reader :filename
    attr_reader :start_time
    attr_reader :end_time
    attr_reader :text

    def initialize(url_or_filename)
      speech_page = Nokogiri::HTML(open url_or_filename)
      @filename = url_or_filename
      @content = speech_page.css '#content'  # Seems to be in a div with the id=content
      @date = nil
      @text = ""

      _parse_speech_text(@content.css('p'))
    end

    def meta_information
      @content.css('.information').text.strip
    end

    def date
      unless @date
        date_string = @content.css('.information .date')
          .text.strip
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
      location_tag = @content.css('p.rtecenter')
      location_tag.text if location_tag
    end


    def _parse_speech_text(contents)
      location_index = contents.find_index do |node|
        node.attribute('class') &&
          node.attribute('class').value =~ /rtecenter/
      end
      location_index = 0 unless location_index

      texts = contents[location_index+1..contents.length].map do |node|
        node.text.strip
      end
      texts = texts.join "\n"

      texts.each_line do |line|
        if not @start_time
          begin
            starting_time = DateTime.parse line.strip
            @start_time = DateTime.new(date.year,
                                       date.month, date.day,
                                       starting_time.hour,
                                       starting_time.minute, 0,
                                       starting_time.offset)
          rescue ArgumentError
          end
        else
          self.text << line
        end
      end
    end # _parse_speech_text

  end # class Extractor

end # module WhitehouseSpeech
