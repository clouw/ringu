class CharactersController < ApplicationController
  include Container::Resolve
  
  resolve :characters_fetcher

  # GET /characters
  def index
    @characters = characters_fetcher.fetch

    render json: @characters
  end
end
