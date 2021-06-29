module Container
  include Ringu::Container

  register :characters_fetcher, CharactersFetcher  
  register :http_client, Faraday
end