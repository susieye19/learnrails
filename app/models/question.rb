class Question < ActiveRecord::Base
  acts_as_commentable

  belongs_to :user

  validates :title, :body, presence: true
end
