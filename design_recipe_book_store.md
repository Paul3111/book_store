BOOK_STORE Model and Repository Classes Design Recipe

1. Design and create the Table

If the table is already created in the database, you can skip this step.

Otherwise, follow this recipe to design and create the SQL schema for your table.

In this template, we'll use an example table students

# EXAMPLE

Table: students

Columns:
id | name | cohort_name

2. Create Test SQL seeds

TRUNCATE TABLE books RESTART IDENTITY
INSERT INTO books (name, cohort_name) VALUES ('Book1', 'Artist1');
INSERT INTO books (name, cohort_name) VALUES ('Books2', 'Artist1');

3. Define the class names

# EXAMPLE
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

Define the attributes of your Model class. You can usually map the table columns to the attributes of the class, including primary and foreign keys.

# EXAMPLE
# Table name: books

# Model class
# (in lib/book.rb)

class Book
  attr_accessor :id, :title, :author_name
end

5. Define the Repository Class interface

# EXAMPLE
# Table name: books

# Repository class
# (in lib/book_repository.rb)

class BookRepository

  # Selecting all records
  # No arguments
  def all
    SELECT id, title, author_name FROM books;
  end
end

6. Write Test Examples

# 1
# Get all students

repo = BookRepository.new

books = repo.all

books.length # =>  2

books[0].id # =>  1
books[0].title # =>  'Book1'
books[0].author_name # =>  'Author1'

books[1].id # =>  2
books[1].title # =>  'Book2'
books[1].author_name # =>  'Author1'

7. Reload the SQL seeds before each test run

# file: spec/student_repository_spec.rb

def reset_students_table
  seed_sql = File.read('spec/seeds_students.sql')
  connection = PG.connect({ host: '127.0.0.1', dbname: 'students' })
  connection.exec(seed_sql)
end

describe StudentRepository do
  before(:each) do 
    reset_students_table
  end

  # (your tests will go here).
end

8. Test-drive and implement the Repository class behaviour

After each test you write, follow the test-driving process of red, green, refactor to implement the behaviour.