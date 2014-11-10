class Option < ActiveRecord::Base
  belongs_to :product
  has_many :details , dependent: :destroy
end
