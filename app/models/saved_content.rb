class SavedContent < ApplicationRecord
  enum content_type: { movie: 'movie', show: 'show' }

  belongs_to :user
end
