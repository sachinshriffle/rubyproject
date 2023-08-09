class OverdueInfo
  attr_accessor :title, :name, :return_date
  def initialize(title,name,return_date)
   @title = title
   @name = name
   @return_date = return_date
  end
end
