# frozen_string_literal: true

module EnvHelpers
  # Utility methods
  class Utils
    class << self
      # Check if a value represents a boolean
      # @param val [Object] object to check if a boolean value
      # @return [Boolean]
      def boolean_value?(val)
        true_value?(val) || false_value?(val)
      end

      alias bool_value? boolean_value?

      # Check if value represents `true`. ('true', 't', or '1')
      # @param val [Object] object to check if a true value
      # @return [Boolean]
      def true_value?(val)
        val = val.to_s.downcase

        return true if val == 'true'
        return true if val == 't'
        return true if val == '1'

        false
      end

      # Check if value represents `false`. ('false', 'f', or '0')
      # @param val [Object] object to check if a false value
      # @return [Boolean]
      def false_value?(val)
        val = val.to_s.downcase

        return true if val == 'false'
        return true if val == 'f'
        return true if val == '0'

        false
      end
    end
  end
end
