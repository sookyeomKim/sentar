class Product < ActiveRecord::Base
	belongs_to :user
	has_many :purchases
	has_many :comments , dependent: :destroy
	has_many :cartitems, dependent: :destroy, foreign_key: "item_id", class_name: "CartItem"
	ham_many :options , dependent: :destroy
	



	default_scope -> { order('created_at DESC') }
	mount_uploader :picture, PictureUploader
	mount_uploader :picture2, PictureDetailUploader
	mount_uploader :picture3, PictureUploader
	validates :user_id, presence: true
	validates :name, presence: true
	validates :price, numericality: true
	validate :picture_size
	validates :quantity, presence: :true

	

	attr_accessor :option1,:option2,:detail1,:detail2

def Product.from_users_followed_by(user)
    	following_ids = "SELECT followed_id FROM relationships
                     WHERE  follower_id = :user_id"
           where("user_id IN (#{following_ids}) OR user_id = :user_id",
          user_id: user.id)

  end

  
  	

  	
  	 

 

	private
	def picture_size
      if picture.size > 5.megabytes
        errors.add(:picture, "5MB를 초과 할수 없습니다.")
      end
      if picture2.size > 5.megabytes
        errors.add(:picture, "5MB를 초과 할수 없습니다.")
      end
      if picture3.size > 5.megabytes
        errors.add(:picture, "5MB를 초과 할수 없습니다.")
      end

    end
end
