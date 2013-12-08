class Chapter < ActiveRecord::Base
  validates :title, :section, presence: true
end
