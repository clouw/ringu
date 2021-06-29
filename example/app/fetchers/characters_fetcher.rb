class CharactersFetcher
  include Container::Inject
  
  URL = "https://rickandmortyapi.com/api/character"

  inject :http_client
  inject :characters_parser, CharactersParser

  def fetch
    response = http_client.get(URL)
    characters_parser.parse(response.body)
  end  
end