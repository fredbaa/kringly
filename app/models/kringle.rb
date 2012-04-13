class Kringle < ActiveRecord::Base
  belongs_to :user
  belongs_to :manito, :class_name => "User", :foreign_key => "manito_id"
end
