class Band < ActiveRecord::Base
  
  validates :name, presence: :true
  validates :name, uniqueness: :true

  has_many :albums
  has_many :tracks, :through => :albums, :source => :tracks
end
