class Seek < ActiveRecord::Base
  default_scope {order('id ASC')}
  belongs_to :user
  has_many :likes, dependent: :destroy
  has_many :users_liked, through: :likes, source: :user
  validates :content, presence: true
end
