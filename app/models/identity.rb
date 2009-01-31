class Identity < ActiveRecord::Base
  include OpenIdAuthentication
  
  validates_presence_of :identifier,        :message => "can not be blank."
  
  validates_uniqueness_of :identifier,      :message => "is already in use, please use another."
  
  validates_length_of :identifier,          :maximum => 100, 
                                            :allow_nil => true,
                                            :message => "is too long."
                                            
  validate_on_create :valid_id
  
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
  
  protected
  def normalize_id id
    begin
      identifier = normalize_identifier(id)
    rescue OpenIdAuthentication::InvalidOpenId
      identifier = id
      @invalid_id = true
    end
    identifier
  end
  
  def set_identifier id
    write_attribute(:identifier, normalize_id(id))
  end
end
