# frozen_string_literal: true

require_relative 'autoload'

class Library
  include Validator
  STORAGE_FILE = 'library_storage.yml'
  attr_reader :authors, :books, :readers, :orders

  def initialize
    library_data = LibraryStore.new.load
    @authors = library_data[:authors]
    @books   = library_data[:books]
    @readers = library_data[:readers]
    @orders  = library_data[:orders]
  end

  def top_readers(amount = 1)
    distinct_orders_by_book_and_count = ->(orders) { orders.uniq(&:book).count }
    compare_readers = ->(first_reader, second_reader) { first_reader[1] <=> second_reader[1] }

    @orders.group_by(&:reader).transform_values(&distinct_orders_by_book_and_count)
           .to_a.max(amount, &compare_readers).map(&:first)
  end

  def most_popular_books(amount = 1)
    distinct_orders_by_reader_and_count = ->(orders) { orders.uniq(&:reader).count }
    compare_books = ->(first_book, second_book) { first_book[1] <=> second_book[1] }

    @orders.group_by(&:book).transform_values(&distinct_orders_by_reader_and_count)
           .to_a.max(amount, &compare_books).map(&:first)
  end

  def number_of_readers_of_the_most_popular_books(amount = 3)
    most_popular_books = most_popular_books(amount)
    filter_orders_of_most_popular_books = ->(order) { most_popular_books.include?(order.book) }

    @orders.select(&filter_orders_of_most_popular_books).uniq(&:reader).count
  end

  def add(object)
    case object
    when Author then @authors << object
    when Book   then @books   << object
    when Reader then @readers << object
    when Order  then @orders  << object
    else
      raise_error('Unintended object was given')
    end
  end

  def save
    LibraryStore.new.save(authors: @authors, books: @books, readers: @readers, orders: @orders)
  end
end
