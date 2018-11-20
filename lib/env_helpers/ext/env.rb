# frozen_string_literal: true

require 'env_helpers'

class << ENV
  # Compare the value of an ENV variable to a given string.
  #
  # @param var_name [String] ENV variable name
  # @param value [String] comparison string
  # @return [Boolean] `true` if the value of the ENV variable is the same as value
  def equal?(var_name, value)
    EnvHelpers.equal?(var_name, value)
  end

  # Get a number value from an ENV variable or return a default.
  #
  # @param var_name [String] ENV variable name
  # @param default [Object] retured when ENV[var_name] is blank or doesn't exist
  # @return [Float] float representing the ENV value
  def num(var_name, default = nil)
    EnvHelpers.num(var_name, default)
  end

  # Get an integer value from an ENV variable or return a default.
  #
  # @param var_name [String] ENV variable name
  # @param default [Object] retured when ENV[var_name] is blank or doesn't exist
  # @return [Integer] integer representing the ENV value
  def int(var_name, default = nil)
    EnvHelpers.int(var_name, default)
  end

  # Get an array value from an ENV variable
  #
  # @param var_name [String] ENV variable name
  # @param sep [String] string to split ENV value on
  # @return [Array] array of strings representing the ENV value.
  # Defaults to [] if value is blank.
  def array(var_name, sep = ',')
    EnvHelpers.array(var_name, sep)
  end

  # Get a JSON value from an ENV variable
  #
  # @param var_name [String] ENV variable name
  # @raise [JSON::ParserError] if value is invalid JSON
  # @return [Object] array of strings representing the ENV value.
  def json(var_name, default = nil)
    EnvHelpers.json(var_name, default)
  end

  # Get an boolean value from an ENV variable or return a default.
  # Will return the default if there is a non-boolean like value for the ENV variable.
  #
  # @param var_name [String] ENV variable name
  # @param default [Object] retured when ENV[var_name] is blank
  # or doesn't represent a numeric value
  # @return [Boolean] boolean representing the ENV value
  def bool(var_name, default = nil)
    EnvHelpers.bool(var_name, default)
  end

  # Check if an ENV variable represents `true`. ('true', 't', or '1').
  # Returns false if environment variable isn't defined.
  #
  # @param var_name [String] ENV variable name
  # @return [Boolean]
  def true?(var_name)
    EnvHelpers.true?(var_name)
  end

  # Check if an ENV variable represents `false`. ('false', 'f', or '0').
  # Returns false if environment variable isn't defined.
  #
  # @param var_name [String] ENV variable name
  # @return [Boolean]
  def false?(var_name)
    EnvHelpers.false?(var_name)
  end
end
