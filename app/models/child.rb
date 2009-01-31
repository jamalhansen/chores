class Child < ActiveRecord::Base
  belongs_to :identity
  belongs_to :parent,               :class_name => 'Identity'
  
  validates_presence_of :identity,  :message => 'can not be blank.'
  validates_presence_of :parent,    :message => 'can not be blank.'
end
