class AddActivationToUsers < ActiveRecord::Migration
  def change
    add_column :users, :activation_digest, :string  #activation token값이 변형 되어 유저 객체에 저장될 속성
    add_column :users, :activated, :boolean, default: false # 활성화 비활성화 유무
    add_column :users, :activated_at, :datetime # 활성화 된 시간
  end
end
