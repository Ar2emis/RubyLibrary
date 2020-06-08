# frozen_string_literal: true

require 'date'
require_relative 'bin/library'

# Creating of the Library instance
library = Library.new

# Creating of the Author instance with all parameters
john_doe = Author.new('John Doe', 'Noname author of noname books')

# Creating of the Author instance without biography
jane_doe = Author.new('Jane Doe')

# Adding authors to the library
library.add_author(john_doe)
library.add_author(jane_doe)

# Creating og the Book instance
johns_book = Book.new('How not to be unknown', john_doe)
janes_book = Book.new('How to be known', jane_doe)

# Adding books to the library
library.add_book(johns_book)
library.add_book(janes_book)

# Creating of the Reader instance
jack_roe = Reader.new('Jack Roe', 'jack_roe@gmail.com', 'Ottawa', 'Riverdale Ave', 12)
jill_roe = Reader.new('Jill Roe', 'jill_roe@gmail.com', 'Oslo', 'Heimdalsgata', 3)

# Adding readers to the library
library.add_reader(jack_roe)
library.add_reader(jill_roe)

# Creating of the Order instance with all parameters
jacks_order = Order.new(johns_book, jack_roe, Date.today)

# Creating of the Order without date
jills_order = Order.new(janes_book, jill_roe)

# Adding orders to the library
library.add_order(jacks_order)
library.add_order(jills_order)

# Calling statistics methods
puts '-----------------------------------------------------------------------------------------------------------------'
puts "Top readers\n\n"
library.top_readers.each { |reader| puts "#{reader}\n" }
puts '-----------------------------------------------------------------------------------------------------------------'
puts "Most popular books\n\n"
library.most_popular_books.each { |book| puts "#{book}\n" }
puts '-----------------------------------------------------------------------------------------------------------------'
puts "Number of readers of the most popular books: #{library.number_of_readers_of_the_most_popular_books}"
puts '-----------------------------------------------------------------------------------------------------------------'

# Saving library
library.save
