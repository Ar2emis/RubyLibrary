# frozen_string_literal: true

class Book
  include Validator
  attr_reader :title, :author

  def initialize(title, author)
    validate_data(title: title, author: author)

    @title = title
    @author = author
  end

  def to_s
    "Book\n\
  Title: \"#{title}\"\n\
  Author: #{author.name}"
  end

  private

  def validate_data(title:, author:)
    validate_title(title)
    validate_author(author)
  end

  def validate_title(title)
    validate_class(String, title)
    validate_non_empty_string(title)
  end

  def validate_author(author)
    validate_class(Author, author)
  end
end
