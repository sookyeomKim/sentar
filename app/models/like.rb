class Like < ActiveRecord::Base
	belongs_to :microposts
	validates :micropost_id, presence: true
	validates :user_id, presence: true
end
