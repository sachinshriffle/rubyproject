require_relative "library.rb"
require_relative "reports.rb"

class Main
	def start
	  lib = Library.new
	  rep = Reports.new
	  istrue = true
	  i = 0 
	  while istrue
	   break if i == 3
	   puts "\n............Library Management System............."
	   puts "\n.....Main Menu...."
	   puts "1. Manage Book"
	   puts "2. Add Borrower"
	   puts "3. Search Book"
	   puts "4. Manage Borrowing"
	   puts "5. Overdue Books"  
	   puts "6. Reports"
	   puts "7. Exit\n"
	   print "Please Enter Your Choice:"
	   choice = gets.chomp.to_i
	   case choice
	    when 1
	     lib.manage_book
	    when 2
	     lib.add_borrower
	    when 3
	     lib.search_book
	    when 4
	     lib.manage_borrower
	    when 5
	     # overdue books ke liye use kr rhe he
	     rep.common_method(lib.overdue, "Overdue Info", 2)
	    when 6
	     rep.reports(lib)
	    when 7
	     puts "Exiting......."
	     istrue = false 
	    else
	     puts "Invalid choice"
	     i += 1
	    end
	  end
	end
end
Main.new.start