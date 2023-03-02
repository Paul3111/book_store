BookStore Model and Repository Classes Design Recipe
1. Design and create the Table

Table: books

Columns:
id | title | author_name

2. Create Test SQL seeds

-- (file: spec/seeds_book_store.sql)

TRUNCATE TABLE books RESTART IDENTITY;
INSERT INTO books (title, author_name) VALUES ('Book1', 'Author1');
INSERT INTO books (title, author_name) VALUES ('Book2', 'Author2');

3. Define the class names

# Table name: books

# Model class
# (in lib/book.rb)
class Book
end

# Repository class
# (in lib/book_repository.rb)
class BookRepository
end

4. Implement the Model class
# Table name: books

# Model class
# (in lib/book.rb)

class Book
  attr_accessor :id, :title, :author_name
end

5. Define the Repository Class interface

Your Repository class will need to implement methods for each "read" or "write" operation you'd like to run against the database.

# Table name: books

# Repository class
# (in lib/book_repository.rb)

class BookRepository

  # Selecting all records
  # No arguments
  def all
    # SELECT id, title, author_name FROM books;
  end
end

6. Write Test Examples

# 1
# Get all books

repo = BookRepository.new

books = repo.all

books.length # =>  2

books.first.id # =>  1
books.first.title # =>  'Book1'
books.first.author_name # =>  'Author1'

books[1].id # =>  2
books[1].title # =>  'Book2'
books[1].author_name # =>  'Author1'

7. Reload the SQL seeds before each test run

# file: spec/book_store_repository_spec.rb

def reset_books_table
  seed_sql = File.read('spec/seeds_book_store.sql')
  connection = PG.connect({ host: '127.0.0.1', dbname: 'book_store_test' })
  connection.exec(seed_sql)
end

describe BookRepository do
  before(:each) do 
    reset_books_table
  end

  # (your tests will go here).
end

8. Test-drive and implement the Repository class behaviour

After each test you write, follow the test-driving process of red, green, refactor to