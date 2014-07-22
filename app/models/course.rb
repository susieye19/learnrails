class Course < ActiveRecord::Base
  extend FriendlyId
  friendly_id :name, use: [:slugged, :history]

  validates :name, presence: true

	has_many :chapters, dependent: :destroy

  def should_generate_new_friendly_id?
    name_changed?
  end
end
