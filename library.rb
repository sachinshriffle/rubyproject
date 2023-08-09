require "date"
require_relative "book.rb"
require_relative "borrower.rb"
require_relative "overdueinfo.rb"

class Library
  attr_accessor :book , :borrowed_book , :borrower, :overdue
  include BooksValidation
  include BorrowersValidation
  def initialize
   @borrower = []
   @overdue = []
   @book = []
  end 

  def manage_book
    istrue = true
    i = 0 
    while istrue
      break if i==3
      puts "\n1. Add Book"
      puts "2. Update Book"
      puts "3. Delete book"
      puts "4. Exit"
      print "Enter Your Choice:"
      choice = gets.chomp.to_i
      case choice
      when 1
        add_book
      when 2 
        update_book
      when 3
        delete_book
      when 4 
        istrue = false
        return
      else
        puts "Invalid Choice"
        i += 1
      end
    end
  end

  def add_book
	  booktitle = string_validation("\nEnter book title:")
    return unless stop_time(booktitle)
	  author = string_validation("Enter author name:")
    return unless stop_time(author)
    @book.each do |book|
      if (book.booktitle == booktitle && book.author == author)
        puts "book Already Exist!"
        return
      end
    end
    publication_year = integer_validation("Enter publication year:")
    return unless stop_time(publication_year) 
    @book.push(Book.new(booktitle, author, publication_year))
    puts "\nBook Added Successfully!"
  end

  def update_book
    istrue = true
    i = 0 
    while istrue
      break if i == 3
      puts "\n1. Update Book By Title"
      puts "2. Update Book By Author"
      puts "3. Update Book By publication Year"
      puts "4. Exit"
      puts "Please Enter your Choice:"
      choice = gets.chomp.to_i
      case choice
      when 1 
        by_update_method("title",1)
      when 2
        by_update_method("author",2)
      when 3
        by_update_method("publication year",3)
      when 4
        istrue = false
        return
      else
        puts "Invalid Choice"
        i += 1
      end 
    end
  end

  def by_update_method(text,num)
    value = string_validation("\nEnter #{text} you want to update:")
    return unless stop_time(value)
    index = book_index(value, @book, num)
    if index == nil
      puts "#{text} Not Found"
    else
      if (num == 1)
        new_title = string_validation("Enter New Book Title:")
        return unless stop_time(new_title)
        @book[index].booktitle = new_title
        puts "Book Update Successfully!"
      elsif (num == 2)
        new_author = string_validation("Enter New Book Author:")
        return unless stop_time(new_author)
        @book[index].author = new_author
        puts "Book Update Successfully!"
      else
        new_year = string_validation("Enter New Book Publication Year:")
        return unless stop_time(new_year)
        @book[index].publication_year = new_year
        puts "Book Update Successfully!"
      end
    end
  end

  def delete_book
    title = string_validation("\nEnter book title you want to delete:")
    return unless stop_time(title)
    index = book_index(title, @book)
    if (index == nil)
      puts "Book Not Found\n"
    else
      @book.delete_at(index)
      puts "Book Delete successfully!\n"
    end
  end

  def search_book
	  search = string_validation("\nEnter title or author name: ")
    return unless stop_time(search)
	  result = @book.select{ |book| book.booktitle.include?(search) || book.author.include?(search) }
	  if result.empty?
	    puts "Book Not Found"
	  else
	    puts "Search Results:"
	    result.each do |book|
	      puts "Title: #{book.booktitle}\nAuthor: #{book.author}\nPublication Year: #{book.publication_year}"
	    end
	  end
  end

  def add_borrower
	  borrowername = string_validation("\nEnter borrower name:")
    return unless stop_time(borrowername)
	  cont_info = num_check("Enter contact information:")
    return unless stop_time(cont_info)
    @borrower.push(BorrowerInfo.new(borrowername, cont_info))
    puts "Borrower Added Successfully!"
  end

  def manage_borrower
    booktitle = string_validation("\nEnter book title:")
    return unless stop_time(booktitle)
    index = book_index(booktitle, @book, 1)
    if index == nil
      puts "Book not found"
    else
      borrowername = string_validation("Enter borrower name:")
      return unless stop_time(borrowername)
      result = @borrower.select{ |borrower| borrower.borrowername.include?(borrowername)}
      if result.empty?
        puts"Borrower name Not Found"
      else
        for i in 1..3 do
          print "Enter return date(DD-MM-YYYY):"
          return_date = gets.chomp
          if date_validation(return_date)
            puts "Book Checked Out Successfully!"
            @overdue.push(OverdueInfo.new(booktitle, borrowername, return_date))
            @book.delete_at(index)
            break
          else
            puts "please enter valid date"
            if (i == 3)
              puts "time limit exceed"
              return
            end
          end
        end
      end
    end
  end
end