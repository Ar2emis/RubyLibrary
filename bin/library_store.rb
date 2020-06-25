# frozen_string_literal: true

class LibraryStore
  STORAGE_DIRECTORY = 'db'
  STORAGE_FILE = 'library_storage.yml'
  attr_accessor :data

  def initialize
    @data = db_initialized? ? load : initialize_db
  end

  def save
    store = YAML::Store.new(storage_file_path)

    store.transaction do
      data.each { |key, value| store[key] = value }
    end
  end

  private

  def load
    store = YAML::Store.new(storage_file_path)

    store.transaction do
      store.roots.to_h { |key| [key, store[key]] }
    end
  end

  def initialize_db
    Dir.mkdir(File.join(STORAGE_DIRECTORY))

    standard_data
  end

  def storage_file_path
    File.join(STORAGE_DIRECTORY, STORAGE_FILE)
  end

  def db_initialized?
    Dir.exist?(STORAGE_DIRECTORY)
  end

  def standard_data
    {
      authors: [],
      books: [],
      readers: [],
      orders: []
    }
  end
end
