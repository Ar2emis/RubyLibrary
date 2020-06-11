# frozen_string_literal: true

require 'date'

# Library order class
class Order
  attr_reader :book, :reader, :date

  def initialize(book:, reader:, date: Date.today)
    self.book   = book
    self.reader = reader
    self.date   = date
  end

  def to_s
    "Order\n\
    Book: \"#{book.title}\" #{book.author.name}\n\
    Reader: #{reader.name}\n\
    Date: #{date}"
  end

  private

  def book=(book)
    Validator.validate_class(expected_class: Book, instance_class: book.class,
                             error_class: LibraryArgumentError, message: 'book must be a Book object')

    @book = book
  end

  def reader=(reader)
    Validator.validate_class(expected_class: Reader, instance_class: reader.class,
                             error_class: LibraryArgumentError, message: 'reader must be a Reader object')

    @reader = reader
  end

  def date=(date)
    Validator.validate_class(expected_class: Date, instance_class: date.class,
                             error_class: LibraryArgumentError, message: 'date must be a Date object')

    @date = date
  end
end
