class Order < ActiveRecord::Base
  attr_accessible :user_id, :order_date, :status, :order_no, :shipping_cost, :pay_type
  
  has_many :line_items
  belongs_to :customer,
             :class_name => 'User',
             :foreign_key => 'user_id'

    
  def generate_reference(user)
     Time.now.strftime("%d%m%y%H%M")
  end

  def before_create
    self[:order_date] = Date.today
  end

  def total_price
    total = line_items.collect {|i| i.title * i.unit_price }.sum
    return total.to_f + shipping_cost.to_f
  end

  def items=(collection)
    collection.each do |o|
      LineItem.create(:product_id => o.product.id, :quantity => o.title, :unit_price => o.product.price, :order_id => self.id)
    end
  end

  def self.generate_reference
    Order.next_invoice_suffix
  end

  def self.next_invoice_suffix
    previous = Order.find(:first, :order => 'id DESC')

    if previous.nil? || previous.order_no.blank?
      
    else
      previous.order_no.succ.list(4, "0")
    end
  end
end
