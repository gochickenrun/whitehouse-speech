require 'test_helper'


describe "March 2014 First Lady" do
  speech = nil

  before do
    speech = WhitehouseSpeech::Extractor.new file_fixture '2014_march_firstlady_time_mixed.html'
  end

  describe "separating time when in P tag with speech text" do
    it "returns the time" do
      speech.time.must_equal "1:41 P.M. EST"
    end
  end
end
