class Question < ActiveRecord::Base
  acts_as_commentable

  belongs_to :user

  validates :subject, :details, presence: true
end
