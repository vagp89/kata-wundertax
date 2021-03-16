require "csv"

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
       puts "Book found"
       puts "Title: #{matching_data["title"]}"
       puts "Author: #{matching_data["authors"]}"
       puts "Description: #{matching_data["description"]}"
    else
       puts "Magazine found"
       puts "Title: #{matching_data["title"]}"
       puts "Author: #{matching_data["authors"]}"
       puts "Published: #{matching_data["publishedAt"]}"
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
  matching_data =  data.select {|hash| hash["authors"] == author }
  if matching_data.length == 0
    puts "No book or magazine found for author: #{author}"
  else
    matching_data.each do |element|
      puts "-------------"
      puts "Title: #{element["title"]}"
      puts "Isbn: #{element["isbn"]}"
      puts "Authors: #{element["authors"]}"
      if (!element["description"].nil?)
      puts "Description: #{element["description"]}"
      else
        puts "Published at: #{element["publishedAt"]}"
      end
      puts "--------------"
    end
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
  sorted_data.each do |element|
    puts "-------------"
    puts "Title: #{element["title"]}"
    puts "Isbn: #{element["isbn"]}"
    puts "Authors: #{element["authors"]}"
    if (!element["description"].nil?)
      puts "Description: #{element["description"]}"
    else
      puts "Published at: #{element["publishedAt"]}"
    end
    puts "--------------"
  end
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
    puts "here"
    sort_magazines_books_by_title
  end
end


main()
