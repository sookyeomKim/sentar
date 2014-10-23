class Micropost < ActiveRecord::Base
	belongs_to :user
  has_many :comments , dependent: :destroy
  has_many :likes , dependent: :destroy

	default_scope -> { order('created_at DESC')}
	mount_uploader :picture, PictureUploader
	validates :user_id, presence: true
	validates :content, presence: true, length: { maximum: 140}
	validate :picture_size
  validates :title, presence: true, length: {maximum: 50}



	 # Returns microposts from the users being followed by the given user.
 def Micropost.from_users_followed_by(user)
    #following_ids = user.following_ids
    #where("user_id IN (:following_ids) OR user_id = :user_id",
          #following_ids: following_ids, user_id: user)
     following_ids = "SELECT followed_id FROM relationships
                     WHERE  follower_id = :user_id"
    where("user_id IN (#{following_ids}) OR user_id = :user_id",
          user_id: user.id)


  end

	private

	 def picture_size
      if picture.size > 5.megabytes
        errors.add(:picture, "should be less than 5MB")
      end
    end


end
