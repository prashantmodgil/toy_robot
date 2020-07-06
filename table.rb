class Table
 attr_accessor :rows, :columns

 def initialize(rows, columns)
   raise 'Invalid rows or columns value' if !((rows.is_a? Integer) && (columns.is_a? Integer))
   @rows = rows
   @columns = columns
 end

end
