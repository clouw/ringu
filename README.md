# Ringu

 ## IMPORTANT: Not ready for production

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'ringu', '~> 0.1.1.pre.alpha'
```

And then execute:

    $ bundle install

Or install it yourself as:

    $ gem install ringu

## Usage

### Create container

Create file `container.rb` in `app/deps` directory

```bach
mkdir app/deps

echo 'module Container\n  include Ringu::Container\n\n  # Deps\n  # register :name, class\nend\n' >> app/deps/container.rb
```

Example [example/app/deps/container.rb](https://github.com/ramon-sg/ringu/blob/master/example/app/deps/container.rb)

### Register your dependencies

```ruby
module Container
  include Ringu::Container

  register :characters_fetcher, CharactersFetcher  
  register :http_client, Faraday
end

```

### Inject your dependencies 

```ruby
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
```

Example [example/app/fetchers/characters_fetcher.rb](http://github.com/ramon-sg/ringu/blob/master/example/app/fetchers/characters_fetcher.rb)

Example test [example/test/fetchers/characters_fetcher_test.rb](http://github.com/ramon-sg/ringu/blob/master/example/test/fetchers/characters_fetcher_test.rb)

### Resolve dependency

```ruby
Container.resolve(:characters_fetcher)
```

or

```ruby
class CharactersController < ApplicationController
  include Container::Resolve
  
  resolve :characters_fetcher

  # GET /characters
  def index
    @characters = characters_fetcher.fetch

    render json: @characters
  end
end
```

Example [example/app/fetchers/characters_fetcher.rb](http://github.com/ramon-sg/ringu/blob/master/example/app/controllers/characters_controller.rb)

Example test [example/test/fetchers/characters_fetcher_test.rb](http://github.com/ramon-sg/ringu/blob/master/example/test/controllers/characters_controller_test.rb)


## Example rails project

[Rails project](http://github.com/ramon-sg/ringu/blob/master/example)


# TODO

- [ ] Add tests
- [ ] Add docs and more exmaples
- [ ] Refactor


## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/ramon-sg/ringu.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).
