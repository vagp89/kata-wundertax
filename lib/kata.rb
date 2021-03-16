require "csv"

def pretty_print_book(book)
  puts "-----------------------"
  puts "Title: #{book["title"]}"
  puts "ISBN: #{book["isbn"]}"
  puts "Authors: #{book["authors"]}"
  puts "Description: #{book["description"]}"
  puts "-----------------------"
end

def pretty_print_magazine(magazine)
  puts "-----------------------"
  puts "Title: #{magazine["title"]}"
  puts "ISBN: #{magazine["isbn"]}"
  puts "Authors: #{magazine["authors"]}"
  puts "Published: #{magazine["publishedAt"]}"
  puts "-----------------------"
end

def pretty_print_books_magazines(books_magazines)
  books_magazines.each do |element|
    is_book = !element["description"].nil?
    if is_book
      pretty_print_book(element)
    else
      pretty_print_magazine(element)
    end
  end
end

def print_books_mags
  filepath = "data/books.csv"
  filepathMags = "data/magazines.csv"

  puts "----List of Books----"
  CSV.open(filepath, 'r', {:col_sep => ";", headers: true}).each do |row|
    puts "-------------"
    puts "Title: #{row[0]}"
    puts "Isbn: #{row[1]}"
    puts "Authors: #{row[2]}"
    puts "Description: #{row[3]}"
    puts "--------------"
  end

   puts "\n"
   puts "----List of Magazines----"

   CSV.open(filepath, 'r', {:col_sep => ";", headers: true}).each do |row|
    puts "-------------"
    puts "Title: #{row[0]}"
    puts "Isbn: #{row[1]}"
    puts "Authors: #{row[2]}"
    puts "Published at: #{row[3]}"
    puts "--------------"
  end
end

def find_book_or_magazine_by_isbn(isbn)
  filepath = "data/books.csv"
  filepathMags = "data/magazines.csv"
  data = []
  CSV.foreach(filepath, {:col_sep => ";", headers: true}) do |row|
    data << row.to_hash
  end
  CSV.foreach(filepathMags, {:col_sep => ";", headers: true}) do |row|
    data << row.to_hash
  end
  matching_data =  data.select {|hash| hash["isbn"] == isbn }.first
  if matching_data.nil?
    puts "No book or magazine found for isbn: #{isbn}"
  else
    is_book = !matching_data["description"].nil?
    if (is_book)
       pretty_print_book(matching_data)
    else
       pretty_print_magazine(matching_data)
    end
  end
end

def find_books_and_magazines_by_author(author)
  filepath = "data/books.csv"
  filepathMags = "data/magazines.csv"
  data = []
  CSV.foreach(filepath, {:col_sep => ";", headers: true}) do |row|
    data << row.to_hash
  end
  CSV.foreach(filepathMags, {:col_sep => ";", headers: true}) do |row|
    data << row.to_hash
  end
  matching_data =  data.select {|hash| hash["authors"].split(',').include? author }
  if matching_data.length == 0
    puts "No book or magazine found for author: #{author}"
  else
    puts "----Books and magazines found by author #{author}----\n"
    pretty_print_books_magazines(matching_data)
  end
end

def sort_magazines_books_by_title
  filepath = "data/books.csv"
  filepathMags = "data/magazines.csv"
  data = []
  CSV.foreach(filepath, {:col_sep => ";", headers: true}) do |row|
    data << row.to_hash
  end
  CSV.foreach(filepathMags, {:col_sep => ";", headers: true}) do |row|
    data << row.to_hash
  end
  sorted_data =  data.sort_by {|hash| hash["title"] }
  puts "----Sorted Books and magazines by title----\n"
  pretty_print_books_magazines(sorted_data)
end


def main
  puts "----Welcome to book, magazines system----"
  puts "Press 1 to see all magazines and books in the system"
  puts "Press 2 to find a magazine or book by isbn"
  puts "Press 3 to find a book or magazine by author"
  puts "Press 4 to sort magazines and books by title"
  answer = gets.chomp
  answer_number = answer.to_i

  if answer_number == 1
    puts "pressed 1"
    print_books_mags
  elsif answer_number == 2
    puts "Please input the ISBN for which you want to find a book or magazine"
    isbn_to_find = gets.chomp
    find_book_or_magazine_by_isbn(isbn_to_find)
  elsif answer_number == 3
    puts "Please input authors email for which you want to find magazines and books"
    author = gets.chomp
    find_books_and_magazines_by_author(author)
  else
    sort_magazines_books_by_title
  end
end


main()
