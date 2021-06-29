# frozen_string_literal: true

# TODO: add tests
module Ringu
  module Container
    def self.included(base)
      base.extend(ClassMethods)
      const_set "Inject", Ringu::Injector.create(base.deps)
      const_set "Resolve", Ringu::Resolver.create(base.deps)
    end

    module ClassMethods
      def deps
        @deps ||= Ringu::Deps.new
      end

      def register(name, value)
        deps.register(name, value)
      end

      def resolve(name)
        deps.resolve(name)
      end
    end
  end
end
