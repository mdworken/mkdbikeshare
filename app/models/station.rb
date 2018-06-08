class Station < ApplicationRecord
  validates :id, uniqueness: true
  before_create :ensure_valid_id #not sure if it's still smart to put this in if the controller already validates it
  
  def ensure_valid_id
    throw :abort unless valid_id?
  end

  def valid_id?
    id.is_a?(Integer) and id > 0 and id <=526 #current max of the ids, hardcoding for now
  end
end