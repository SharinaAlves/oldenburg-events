class Event < ApplicationRecord
  belongs_to :category
  has_many :bookmarks

  geocoded_by :address
  after_validation :geocode, if: :will_save_change_to_address?
end
