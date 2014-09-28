class CreateMicroposts < ActiveRecord::Migration
  def change
    create_table :microposts do |t|
      t.text :content
      t.integer :user_id

      t.timestamps
    end
    add_index :microposts, [:user_id, :created_at]
    # 모든 글들을 유저 아이디와 최근 생성된  순서 순으로 가져오기 위해 :user_id, 와 :created_at 를 인데스로 추가 (복수 인덱스 허용 )
  
  end
end
 