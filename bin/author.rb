# frozen_string_literal: true

# Library book author class
class Author
  attr_reader :name, :description

  def initialize(name, biography = nil)
    self.name      = name
    self.biography = biography
  end

  def to_s
    "Author\n\
  Name: #{name}\n\
  Description: #{biography.nil? ? 'None' : biography}"
  end

  private

  def name=(name)
    Validator.validate_class(expected_class: String, instance_class: name.class,
                             error_class: LibraryArgumentError, message: 'name must be a String object')
    Validator.validate_non_empty_string(string: name,
                                        error_class: LibraryArgumentError, message: 'name must not be empty')

    @name = name
  end

  def biography=(biography)
    Validator.validate_class_or_nil(expected_class: String, instance_class: biography.class,
                                    error_class: LibraryArgumentError, message: 'biography must be String object')

    @biography = biography
  end
end
