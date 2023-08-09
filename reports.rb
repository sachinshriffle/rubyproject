require "csv"
class Reports
  def reports(lib)
    istrue = true
    i = 0
    while istrue       
      break if i == 3
      puts "\n1. Available Books"
      puts "2. Borrowed Books"
      puts "3. Borrowers Borrowing History"
      puts "4. Export"
      puts "5. Exit"
      print "Please Enter your choice:"
      choice = gets.chomp.to_i
      case choice
      when 1
        common_method(lib.book, "Available books", 1)
      when 2
        common_method(lib.overdue,"Borrowed books", 2)
      when 3
        common_method(lib.overdue, "Borrowers borrowing history", 2)
      when 4
        export(lib)
      when 5
        istrue = false
        return
      else 
        puts "Invalid Choice"
        i += 1
      end
    end
  end

  def export(lib)
    istrue = true
    i = 0
    while istrue
      break if i == 3
      puts "\n1. Export All Books"
      puts "2. Export Borrowing History"
      puts "3. Exit"
      print "Enter your choice:"
      choice = gets.chomp.to_i
      case choice
      when 1 
        export_all_books(lib.book)
      when 2 
        export_borrowing_history(lib.overdue)
      when 3
        istrue = false
        return
      else
        puts "Invalid choice!"
        i += 1
      end
    end
  end
   
  def export_all_books(book)
    CSV.open("books_details.csv", "a") do |csv|
      book.each do |book|
        temp_arr = [book.booktitle, book.author, book.publication_year]
        csv << temp_arr
      end
    end
    puts "Export All Books Sucessfully!"
  end

  def export_borrowing_history(overdue)
    CSV.open("borrowers_details.csv", "a") do |csv|
      overdue.each do |borrowers|
        temp_arr = [borrowers.title, borrowers.name, borrowers.return_date]
        csv << temp_arr
      end
    end
    puts "Export Borrowing History Sucessfully!"
  end
  
  # common method for available books ,overdue info, borrowed books , borrowers borrowing history
  def common_method(common, text, val)
    if common.empty?
      puts "#{text} are not found"
    else
      if (val == 1)
        puts "#{text}:"
        common.each do |value|
          puts "Title: #{value.booktitle}\nAuthor: #{value.author}\nPublication Year: #{value.publication_year}"
        end
      else
        puts "#{text}:"
        common.each do |value|
          puts "Title: #{value.title}\nBorrower: #{value.name}\nReturn Date: #{value.return_date}"
        end
      end
    end
  end
end