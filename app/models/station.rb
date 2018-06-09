class Station < ApplicationRecord
  validates :id, uniqueness: true
  
  validate :ensure_valid_id 
  
  def ensure_valid_id
    errors.add(:id, "must be an integer from 0 to 526") unless valid_id?
  end

  def valid_id?
    id.is_a?(Integer) and id > 0 and id <=526 #current max of the ids, hardcoding for now
  end
end