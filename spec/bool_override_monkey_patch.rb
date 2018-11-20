# frozen_string_literal: true

module EnvHelpers
  class << self
    def true_value?(val)
      val == 'false'
    end

    def false_value?(val)
      val == 'true'
    end
  end
end
