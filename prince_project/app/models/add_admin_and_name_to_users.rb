class AddAdminAndNameToUsers < ActiveRecord::Base
  attr_accessible :admin, :name
end
