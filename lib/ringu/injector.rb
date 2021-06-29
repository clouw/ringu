# frozen_string_literal: true

# TODO: add tests
module Ringu
  module Injector
    extend self

    def create(deps)
      Module.new do
        define_method(:deps) { deps }

        def self.included(klass)
          klass.extend ClassMethods
          klass.send :include, InstanceMethods
        end
      end
    end

    module ClassMethods
      def inject(name, klass = nil)
        attr_accessor name

        injector[name] = {
          klass: klass
        }
      end

      def injector
        @injector ||= {}
      end
    end

    module InstanceMethods
      def initialize(**kwargs)
        self.class.injector.each do |name, options|
          term = kwargs[name] || options[:klass]
          resource = deps.resolve(name, term)
          instance_variable_set("@#{name}", resource)
        end
      end
    end
  end
end
