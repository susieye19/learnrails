class Chapter < ActiveRecord::Base
  extend FriendlyId
  friendly_id :title, use: [:slugged, :history]

  acts_as_commentable

  validates :title, :section, :free, :slug, presence: true

  belongs_to :course

  def should_generate_new_friendly_id?
    title_changed?
  end
end
