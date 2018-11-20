# frozen_string_literal: true

require 'json'

require 'env_helpers/version'
require 'env_helpers/utils'

# Helper methods to improve ENV functionality
module EnvHelpers
  class << self
    attr_accessor :rescue_json

    # Compare the value of an ENV variable to a given string.
    #
    # @param var_name [String] ENV variable name
    # @param value [String] comparison string
    # @return [Boolean] `true` if the value of the ENV variable is the same as value
    def equal?(var_name, value)
      return false unless ENV.key?(var_name)

      ENV[var_name] == value
    end

    # Get a number value (using to_f) from an ENV variable or return a default.
    #
    # @param var_name [String] ENV variable name
    # @param default [Object] retured when ENV[var_name] is blank or doesn't exist
    # @return [Float] float representing the ENV value
    def num(var_name, default = nil)
      return default unless ENV.key?(var_name)

      n = ENV[var_name]

      return default if n == ''

      n.to_f
    end

    # Get an integer value (using to_i) from an ENV variable or return a default.
    #
    # @param var_name [String] ENV variable name
    # @param default [Object] retured when ENV[var_name] is blank or doesn't exist
    # @return [Integer] integer representing the ENV value
    def int(var_name, default = nil)
      return default unless ENV.key?(var_name)

      n = ENV[var_name]

      return default if n == ''

      n.to_i
    end

    # Get an array value from an ENV variable
    #
    # @param var_name [String] ENV variable name
    # @param sep [String] string to split ENV value on
    # @return [Array] array of strings representing the ENV value.
    # Defaults to [] if value is blank.
    def array(var_name, sep = ',')
      return [] unless ENV.key?(var_name)

      ENV[var_name].split(sep)
    end

    # Get a JSON value from an ENV variable
    #
    # @param var_name [String] ENV variable name
    # @raise [JSON::ParserError] if value is invalid JSON
    # @return [Object] array of strings representing the ENV value.
    def json(var_name, default = nil)
      return default unless ENV.key?(var_name)

      JSON.parse(ENV[var_name])
    rescue JSON::ParserError => ex
      raise ex unless rescue_json?

      default
    end

    # @private
    def rescue_json?
      return @rescue_json if defined? @rescue_json

      true
    end

    # Get an boolean value from an ENV variable or return a default.
    # Will return the default if there is a non-boolean like value for the ENV variable.
    #
    # @param var_name [String] ENV variable name
    # @param default [Object] retured when ENV[var_name] is blank
    # or doesn't represent a numeric value
    # @return [Boolean] boolean representing the ENV value
    def bool(var_name, default = nil)
      return default unless ENV.key?(var_name)

      return true if true_value?(ENV[var_name])
      return false if false_value?(ENV[var_name])

      default
    end

    # Check if an ENV variable represents `true`. ('true', 't', or '1').
    # Returns false if environment variable isn't defined.
    #
    # @param var_name [String] ENV variable name
    # @return [Boolean]
    def true?(var_name)
      return false unless ENV.key?(var_name)

      true_value?(ENV[var_name])
    end

    # Check if an ENV variable represents `false`. ('false', 'f', or '0').
    # Returns false if environment variable isn't defined.
    #
    # @param var_name [String] ENV variable name
    # @return [Boolean]
    def false?(var_name)
      return false unless ENV.key?(var_name)

      false_value?(ENV[var_name])
    end

    # Check if a value is true
    # Meant to be overriden / monkey patched to customize functionality
    #
    # @param val [String] value to check if true
    # @return [Boolean]
    def true_value?(val)
      EnvHelpers::Utils.true_value?(val)
    end

    # Check if a value is false
    # Meant to be overriden / monkey patched to customize functionality
    #
    # @param val [String] value to check if false
    # @return [Boolean]
    def false_value?(val)
      EnvHelpers::Utils.false_value?(val)
    end
  end
end
