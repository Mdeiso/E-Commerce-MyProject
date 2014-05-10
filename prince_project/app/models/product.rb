class Product < ActiveRecord::Base
  attr_accessible :description, :image_url, :price, :title
  
  def self.find_products_for_sale
    find(:all, :order => "title")
  end
end
