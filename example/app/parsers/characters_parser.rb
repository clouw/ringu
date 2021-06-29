class CharactersParser
  def parse(data)
    resoponse = JSON.parse(data, symbolize_keys: true)

    return [] if resoponse['results'].blank?

    resoponse['results'].map do |item|
      {
        id: item['id'],
        name: item['name'],
        image: item['image'],
      }
    end
  end
end