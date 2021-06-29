require "test_helper"

class CharactersParserTest < ActiveSupport::TestCase
  setup do
    @subject = CharactersParser.new
  end

  test "should parse characters" do
    data = <<-JSON
      { 
        "results": [
          { "id": 1, "name": "character 1", "image": "/image1.jpg"},
          { "id": 2, "name": "character 2", "image": "/image2.jpg"}
        ]
      }
    JSON

    results = @subject.parse(data)

    assert results.length == 2
    
    assert results[0][:id] == 1
    assert results[0][:name] == 'character 1'
    assert results[0][:image] == '/image1.jpg'
    
    assert results[1][:id] == 2
    assert results[1][:name] == 'character 2'
    assert results[1][:image] == '/image2.jpg'
  end  
  
  test "should return empty array when result is null" do
    data = '{ "results": null }'
    results = @subject.parse(data)

    assert results.length == 0
  end  
end