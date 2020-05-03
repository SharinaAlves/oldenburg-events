class Event < ApplicationRecord
  belongs_to :category
  has_many :bookmarks, through: :bookmark_events

  geocoded_by :address
  searchkick
  after_validation :geocode, if: :will_save_change_to_address?
end
