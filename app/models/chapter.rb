class Chapter < ActiveRecord::Base
  extend FriendlyId
  friendly_id :title, use: [:slugged, :history]

  acts_as_commentable
  has_many :comments

  validates :title, :section, :slug, presence: true

  def should_generate_new_friendly_id?
    title_changed?
  end
end
