class Child < ActiveRecord::Base
  attr_accessor :open_identifier
  before_create :set_identity

  belongs_to :identity,             :foreign_key => :child_id,
                                    :class_name => 'Identity'

  belongs_to :parent,               :foreign_key => :parent_id, 
                                    :class_name => 'Identity'
  
  validates_presence_of :open_identifier,  :message => 'can not be blank.',
                                           :on => :create
  validates_presence_of :identity,         :message => 'can not be blank.',
                                           :on => :update
  validates_presence_of :parent,    :message => 'can not be blank.'

  def set_identity
    self.identity = Identity.find_or_make_if_valid @open_identifier
  end
end
