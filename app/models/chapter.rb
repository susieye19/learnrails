class Chapter < ActiveRecord::Base
  extend FriendlyId
  # friendly_id :title, use: [:slugged, :history], scope: :course
  friendly_id :title, use: [:scoped, :history], scope: :course

  acts_as_commentable

  validates :course_id, :title, :slug, presence: true

  belongs_to :course

  def should_generate_new_friendly_id?
    title_changed?
  end
end
