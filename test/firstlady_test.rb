require 'test_helper'


describe "extracting March 2014 First Lady" do
  speech = nil

  before do
    speech = WhitehouseSpeech::Extractor.new file_fixture '2014_march_firstlady_time_mixed.html'
  end

  it "parses the date" do
    speech.date.strftime("%-m-%-d-%Y").must_equal "3-4-2014"
  end

  it "returns the headlines" do
    speech.headlines[0].must_equal "Remarks by the First Lady at Chinese Immersion School Visit"
    speech.headlines[1].must_be_empty
  end

  it "returns the location" do
    speech.location.must_match(/Public Charter School/)
  end

  it "separates start time when in P tag with speech text" do
    speech.start_time.strftime("%-l:%M %p %z").must_equal "1:41 PM -0500"
  end
end
