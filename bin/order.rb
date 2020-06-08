# frozen_string_literal: true

require 'date'

# Library order class
class Order
  attr_reader :book, :reader, :date

  def initialize(book, reader, date = Date.today)
    validate_data(book, reader, date)

    @book   = book
    @reader = reader
    @date   = date
  end

  def to_s
    "Order\n\
    Book: \"#{@book.title}\" #{@book.author.name}\n\
    Reader: #{@reader.name}\n\
    Date: #{@date}"
  end

  private

  def validate_data(book, reader, date)
    validate_book(book)
    validate_reader(reader)
    validate_date(date)
  end

  def validate_book(book)
    raise ArgumentError, 'Book must be Book object' unless book.is_a?(Book)
  end

  def validate_reader(reader)
    raise ArgumentError, 'Reader must be Reader object' unless reader.is_a?(Reader)
  end

  def validate_date(date)
    raise ArgumentError, 'Date must be Date object' unless date.is_a?(Date)
  end
end
