# frozen_string_literal: true

# Library book class
class Book
  attr_accessor :title, :author

  def initialize(title, author)
    validate_data(title, author)

    @title  = title
    @author = author
  end

  def to_s
    "Book\n\
  Title: \"#{@title}\"\n\
  Author: #{@author.name}"
  end

  private

  def validate_data(title, author)
    validate_title(title)
    validate_author(author)
  end

  def validate_title(title)
    raise ArgumentError, 'Title must be String object and not be empty' if !title.is_a?(String) || title.empty?
  end

  def validate_author(author)
    raise ArgumentError, 'Author must be Author object' unless author.is_a?(Author)
  end
end
