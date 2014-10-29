class Commentboard < ActiveRecord::Base
  belongs_to :post

  validates :body, presence: true
end
