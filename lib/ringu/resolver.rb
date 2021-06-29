# frozen_string_literal: true

# TODO: add tests
module Ringu
  module Resolver
    extend self

    def create(deps)
      Module.new do
        define_method(:deps) { deps }

        def self.included(klass)
          klass.extend ClassMethods
        end
      end
    end

    module ClassMethods
      def resolve(name)
        define_method(name) do
          var_name = "@#{name}"

          return instance_variable_get(var_name) \
            if instance_variable_defined?(var_name)

          instance_variable_set(var_name, deps.resolve(name))
        end
      end
    end
  end
end
