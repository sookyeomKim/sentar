class Comment < ActiveRecord::Base
	self.table_name = "micropost_comments"

	default_scope -> { order('created_at ASC')}
	belongs_to :micropost
	belongs_to :user
	belongs_to :product

end
