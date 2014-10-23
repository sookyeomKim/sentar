class Comment < ActiveRecord::Base
	self.table_name = "micropost_comments"
	belongs_to :micropost
end
