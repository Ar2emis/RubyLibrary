# frozen_string_literal: true

module Validator
  def validate_class(expected_class, instance)
    raise UnexpectedClassError unless expected_class == instance.class
  end

  def validate_non_empty_string(string)
    raise EmptyStringError if string.empty?
  end

  def validate_positive_integer(number)
    raise NegativeOrZeroIntegerError unless number.positive?
  end
end
