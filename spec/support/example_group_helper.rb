module RSpec
  module Core
    class ExampleGroup
      def self.Then(*args, &block)
        args[0] = "Then #{args[0]}" if args[0].is_a?(String)
        it(*args, &block)
      end

      def self.Given(*args, &block)
        args[0] = "Given #{args[0]}" if args[0].is_a?(String)
        describe(*args, &block)
      end

      def self.When(*args, &block)
        args[0] = "When #{args[0]}" if args[0].is_a?(String)
        describe(*args, &block)
      end

      def self.Scenario(*args, &block)
        args[0] = "Scenario: #{args[0]}" if args[0].is_a?(String)
        describe(*args, &block)
      end

      def self.feature(*args, &block)
        args[0] = "Feature: #{args[0]}" if args[0].is_a?(String)
        describe(*args, &block)
      end
    end
  end
end
