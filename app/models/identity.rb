class Identity < ActiveRecord::Base
  include OpenIdAuthentication
  
  validates_presence_of :identifier,        :message => "can not be blank."
  
  validates_uniqueness_of :identifier,      :message => "is already in use, please use another."
  
  validates_length_of :identifier,          :maximum => 100, 
                                            :allow_nil => true,
                                            :message => "is too long."
                                            
  validate_on_create :valid_id

  has_many :parents,             :foreign_key => :parent_id,
                                 :class_name => 'Child'
  has_many :children,            :foreign_key => :child_id,
                                 :class_name => 'Child'  

  def open_id
    return nil if self.identifier.nil?
    self.identifier[7..-2]
  end
  
  def identifier= identifier  
    raise "Cannot update identifier." unless new_record?
    set_identifier identifier
  end 
    
  def open_id= open_id
    raise "Cannot update open_id." unless new_record?
    set_identifier open_id
  end
  
  def valid_id
    errors.add(:identifier, "is not a valid Open ID.") if @invalid_id
  end
  
  def self.find_by_open_id open_id
    id = OpenIdAuthentication::normalize_identifier(open_id)
    find_by_identifier open_id
  end

  def self.find_or_make_if_valid open_id
    begin
      id = self.find_by_open_id open_id
    rescue OpenIdAuthentication::InvalidOpenId
      return nil
    end

    unless id
      id = Identity.new :identifier => open_id 
      id.save
    end
    id
  end
  
    def Identity.normalize_identifier id
    begin
      identifier = OpenIdAuthentication::normalize_identifier(id)
    rescue OpenIdAuthentication::InvalidOpenId
      identifier = nil
    end
    identifier
  end

  protected
  def normalize_id id
    identifier = Identity.normalize_identifier id
    unless identifier
      @invalid_id = true
      identifier = id
    end
    identifier
  end
  
  def set_identifier id
    write_attribute(:identifier, normalize_id(id))
  end
end
