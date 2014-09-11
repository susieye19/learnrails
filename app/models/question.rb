class Question < ActiveRecord::Base
  extend FriendlyId
  friendly_id :subject, use: [:slugged, :history]
  
  acts_as_commentable

  belongs_to :user

  validates :subject, presence: true
  
  def should_generate_new_friendly_id?
    title_changed?
  end
end
