class Shelter < ActiveRecord::Base
	belongs_to :user
	belongs_to :tmap
	validates :user_id , presence: true
	validates :lonlat, presence: true
	has_many :bulletins, dependent: :destroy
  #TYPES = %w( All )
#  TYPES = %w( All Commerce Blog )
#  before_save :set_type
#  validates :type, presence: true, :inclusion => { :in => TYPES }
#
#  def set_type
#  	raiser "You must override this method in each model inheriting from Product!"
#  end
end


=begin
class All < Shelter
  def set_type # If you don't implement this method, an error will be raised
  	self.type = 'All'
  end
end

class Commerce < Shelter
	def set_type
		self.type = 'Commerce'
	end
end

class Blog < Shelter
	def set_type
		self.type = 'Blog'
	end
end
=end
