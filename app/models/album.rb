class Album < ActiveRecord::Base
  
  validates :name, :year, :band_id, { presence: true }
  validates :live, :inclusion => { :in => [true, false] }
  validates :name, :uniqueness => { :scope => :band_id }
  validates :year, :numericality => true
    
  belongs_to :band
  has_many :tracks
end
