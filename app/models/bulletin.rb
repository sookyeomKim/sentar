class Bulletin < ActiveRecord::Base
    # extend FriendlyId #freinlyId젬 파일 확장(우리 자바했을때처럼 그냥 상속받는거라고 보면 됨. 그런데 Ruby에서는 다중상속이 가능함.)
    # friendly_id :title #id 대신에 title속성을 이용해 게시판을 불러오겠다.
    
    has_many :posts, dependent: :destroy #post과 일대다 관계 형성(has_many시 복수형 선언)
                                         #dependent속성에 destroy를 줌으로써 연결된 bulletin 레코드가 삭제될 때 여기에 속하는 모든 posts도 동시에 삭제된다.

    belongs_to :user
    belongs_to :shelter
end
