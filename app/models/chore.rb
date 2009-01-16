class Chore < ActiveRecord::Base
  validates_length_of   :description,   
                        :maximum => 255, 
                        :allow_nil => true, 
                        :message => "Description cannot be longer than 255 characters." 
                        
  validates_presence_of :description, 
                        :message => "Description cannot be blank."
end
