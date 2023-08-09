module BorrowersValidation
  class BorrowerInfo
    attr_accessor :borrowername, :cont_info
    def initialize(borrowername, cont_info)
      @borrowername = borrowername
      @cont_info = cont_info
    end
  end

  # this method call by manage boorwer
  def book_index(value, book, num)
    book.each_with_index do |book , index| 
      if (num == 1 && book.booktitle == value)
        return index
      elsif (num == 2 && book.author == value)
        return index
      else (num == 3 && book.publication_year == value)
        return index
      end
    end
   return nil
  end

  #this method call by manage borrower
  def date_validation(return_date)
    begin
     format = "%Y-%m-%d"
     DateTime.strptime(return_date,format)
      true
    rescue 
      false
    end
  end

  # this method is check the contact information 
  def num_check(text)
    i = 0 
    begin
      break if i == 3
      ist = true 
      print text
      num = gets.chomp.strip
      if (num.match(/\d{10}/) && num.size == 10)
        return num
        ist = false
      else
        puts "Gives A Valid Contact Number"
        i += 1
      end
    end while ist
  end
end