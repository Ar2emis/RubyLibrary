# frozen_string_literal: true

class UnexpectedClassError < StandardError
  STANDARD_MESSAGE = 'Not expected class'

  def initialize(message = nil)
    super(message.nil? ? STANDARD_MESSAGE : message)
  end
end
