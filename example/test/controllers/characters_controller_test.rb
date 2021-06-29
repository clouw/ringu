require "test_helper"

class CharactersControllerTest < ActionDispatch::IntegrationTest
  setup do
    @mock_fetcher = mock('object')
    Container.deps.replace(:characters_fetcher, @mock_fetcher)

  end

  teardown do
    Container.deps.restore!
  end

  test "should get index" do
    characters = []
    @mock_fetcher.expects(:fetch).returns(characters)

    get characters_url, as: :json

    assert_response :success
    assert response.body == '[]'
  end
end
