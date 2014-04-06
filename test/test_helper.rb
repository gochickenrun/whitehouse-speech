require 'minitest/autorun'

require 'whitehouse_speech'

def file_fixture(name)
  File.expand_path "../fixtures/#{name}", __FILE__
end
