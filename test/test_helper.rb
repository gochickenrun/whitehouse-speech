require 'minitest/autorun'
require 'rack/test'

require 'whitehouse_speech'

def file_fixture(name)
  File.expand_path "../fixtures/#{name}", __FILE__
end

# class MiniTest::Unit::TestCase
#   include Rack::Test::Methods
# end

# class MiniTest::Unit::Spec
#   include Rack::Test::Methods
# end
