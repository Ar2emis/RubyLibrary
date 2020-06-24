# frozen_string_literal: true

class NegativeOrZeroIntegerError < StandardError
  STANDARD_MESSAGE = 'Integer was negative or zero'

  def initialize(message = nil)
    super(message.nil? ? STANDARD_MESSAGE : message)
  end
end
