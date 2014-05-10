class Cart 
  attr_reader :items 
     def initialize
        @items = []
     end
      def add_product(product)
       @items << product
   end
   
   def total_price
     @items.sum { |item| item.price }
   end
 
end

