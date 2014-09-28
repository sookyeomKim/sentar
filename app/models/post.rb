class Post < ActiveRecord::Base
    acts_as_taggable#태그연결. Post 모델에 대해서 tag_list속성 메소드 사용 가능. 이 속성을 폼 데이터로 입력받기 위해 strong parameter로 등록해 주어야 한다.
    
    belongs_to :bulletin #Bulletin과 일대다 관계 형성(belongs_to시 단수형 선언)
    mount_uploader :picture, PictureUploader #이미지 업로드관련 db를 마운트 시켜줬다.
    has_many :comments, dependent: :destroy #comments와 일대다 관계 형성
end
