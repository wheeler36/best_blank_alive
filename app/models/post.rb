class Post < ActiveRecord::Base
  acts_as_votable
  
  belongs_to :user
  has_many :comments, dependent: :destroy
  validates :title, presence: true
  validates :content, presence: true
  validates :choice, presence: true
end
