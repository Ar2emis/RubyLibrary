# frozen_string_literal: true

require_relative 'autoload'

class Library
  include Validator
  STORAGE_FILE = 'library_storage.yml'
  attr_reader :authors, :books, :readers, :orders

  def initialize
    @library_store = LibraryStore.new
    @authors = @library_store.authors
    @books = @library_store.books
    @readers = @library_store.readers
    @orders = @library_store.orders
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

  def add(library_object)
    library_group = case library_object
                    when Author then @authors
                    when Book   then @books
                    when Reader then @readers
                    when Order  then @orders
                    else
                      raise_error('Unintended object was given')
                    end

    library_group << library_object
  end

  def save
    @library_store.save
  end
end
