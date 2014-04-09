require 'minitest/autorun'

require 'whitehouse_speech'

def file_fixture(name)
  File.expand_path "../fixtures/#{name}", __FILE__
end


def basic_tests(fixture_name, **results)

  describe "extracting #{fixture_name}" do
    speech = nil

    before do
      speech = WhitehouseSpeech::Extractor.new file_fixture("#{fixture_name}.html"), {verbose: false}
    end

    describe "parsing" do

      it "parses the date" do
        speech.date.strftime("%-m-%-d-%Y").must_equal results[:date]
      end

      it "returns the headlines" do
        speech.headlines[0].must_match results[:headline]
        speech.headlines[1].must_be_empty
      end

      it "returns the location" do
        speech.location.must_match(results[:location])
      end

      it "separates start time when in P tag with speech text" do
        speech.start_time.strftime("%-l:%M %p %z").must_equal results[:start_time]
      end

      it "contains the body of the speech" do
        results[:text_lines].each do |line|
          speech.text.must_match(line)
        end
      end

    end

  end

end
