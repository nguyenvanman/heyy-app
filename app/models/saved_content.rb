class SavedContent < ApplicationRecord
  enum content_type: { movie: 'movie', show: 'show' }

  validates :mhid, uniqueness: true

  belongs_to :user
end
