# frozen_string_literal: true

class Author
  include Validator
  attr_reader :name, :description

  def initialize(name, biography = nil)
    validate_data(name, biography)

    @name      = name
    @biography = biography
  end

  def to_s
    "Author\n\
  Name: #{@name}\n\
  Description: #{@biography.nil? ? 'None' : @biography}"
  end

  private

  def validate_data(name, biography)
    validate_name(name)
    validate_biography(biography)
  end

  def validate_name(name)
    validate_class(String, name.class)
    validate_non_empty_string(name)
  end

  def validate_biography(biography)
    validate_class_or_nil(String, biography.class)
  end
end
