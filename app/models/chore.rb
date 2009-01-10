class Chore < ActiveRecord::Base
  validates_length_of :description, :maximum => 255, :message => "Description cannot be blank and must be less than 255 characters long." 
end
