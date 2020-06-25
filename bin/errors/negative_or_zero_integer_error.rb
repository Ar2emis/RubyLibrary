# frozen_string_literal: true

class NegativeOrZeroIntegerError < StandardError
  STANDARD_MESSAGE = 'Integer was negative or zero'

  def initialize(message = STANDARD_MESSAGE)
    super(message)
  end
end
