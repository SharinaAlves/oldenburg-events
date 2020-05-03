class BookmarkEvent < ApplicationRecord
  belongs_to :event
  belongs_to :bookmark
end
