# frozen_string_literal: true

require "dry-container"

# TODO: add tests
module Ringu
  class Deps
    def initialize
      @deps = {}
      @backup = {}
    end

    def restore!
      @backup.each do |key, value|
        @deps[key] = value
      end
    end

    def register(key, value)
      @deps[key] = value
    end

    def replace(key, value)
      raise "\"#{key}\" key does not exist" \
        unless @deps.key?(key)

      @backup[key] = @deps[key]
      @deps[key] = value
    end

    def resolve(key, term = nil)
      value = term || @deps.fetch(key)

      value.is_a?(Class) ? value.new : value
    end
  end
end
