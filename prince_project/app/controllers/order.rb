class OrdersController < ApplicationController
  layout "store"
  def list
    @orders = current_user.orders
  end
end
