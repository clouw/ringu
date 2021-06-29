require "test_helper"
require "minitest/mock"

def stub()
  mock = MiniTest::Mock.new
  mock.expect(:is_a?, data, [CharactersFetcher::URL])
end

class CharactersFetcherTest < ActiveSupport::TestCase
  setup do
    @mock_client = mock('object')
    @mock_parser = mock('object')
    
    @subject = CharactersFetcher.new(
      http_client: @mock_client,
      characters_parser: @mock_parser
    )
  end

  test "should parse characters returns characters" do
    data = OpenStruct.new body: '[]'
    characters = []

    @mock_client.expects(:get).with(CharactersFetcher::URL).returns(data)
    @mock_parser.expects(:parse).returns(characters)
    
    results = @subject.fetch
  
    assert results == characters
  end
end