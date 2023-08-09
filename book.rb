module BooksValidation
  class Book
		attr_accessor :booktitle, :author, :publication_year
		def initialize(booktitle, author, publication_year)
			@booktitle = booktitle
			@author = author
			@publication_year = publication_year
		end 
  end

  def string_validation(text)
    i = 0 
    begin
      print text
      value = gets.chomp.strip
      if (value.empty? == true)
        puts  "Invalid Input "
        i += 1
        if i == 3
          return false
        end
      else
        break
      end
    end while value.empty?
   value
  end

  def integer_validation(text)
    i = 0 
    begin
     return false if i == 3
     ist = true
     print text
     num = gets.chomp.to_i
      if num.between?(1900, 2023)
       ist = false
       return num
      else
        puts "Invalid Year"
        i += 1
      end
    end while ist
  end  

  def stop_time(value)
    unless value
      puts "\nInput Limit Exceed"
      false
    else  
      return true
    end
  end
end