class Comment < ActiveRecord::Base
  belongs_to :post#post와 일대다 관계형성
  
  validates :body, presence: true#body 속성에 대한 필수항목으로 유효성 검증을 지정
end
