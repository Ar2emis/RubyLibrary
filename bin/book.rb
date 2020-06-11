# frozen_string_literal: true

# Library book class
class Book
  attr_reader :title, :author

  def initialize(title, author)
    self.title  = title
    self.author = author
  end

  def to_s
    "Book\n\
  Title: \"#{title}\"\n\
  Author: #{author.name}"
  end

  private

  def title=(title)
    Validator.validate_class(expected_class: String, instance_class: title.class,
                             error_class: LibraryArgumentError, message: 'title must be a String object')
    Validator.validate_non_empty_string(string: title,
                                        error_class: LibraryArgumentError, message: 'title must not be empty')

    @title = title
  end

  def author=(author)
    Validator.validate_class(expected_class: Author, instance_class: author.class,
                             error_class: LibraryArgumentError, message: 'author must be an Author object')

    @author = author
  end
end
