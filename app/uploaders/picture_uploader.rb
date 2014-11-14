# encoding: utf-8

class PictureUploader < CarrierWave::Uploader::Base

#유저딴 이미지 업로드
  include CarrierWave::MiniMagick #이미지 크기조절 젬을 include시켜준다. 자바랑 헷갈리면 안되는게 루비는 이런식으로 다중상속이 가능하다.
  process resize_to_limit: [215, 215]





#갤러리딴 이미지 업로드
  #업로드한 이미지를 삭제하면 해당 폴더가 남아 있게 된다.
  #아래와 같이 하면 자동으로 빈 디렉토리를 삭제해준다.
  after :remove, :delete_empty_upstream_dirs
  
  def delete_empty_upstream_dirs
    path = ::File.expand_path(store_dir, root)
    Dir.delete(path) # fails if path not empty dir
  
    path = ::File.expand_path(base_store_dir, root)
    Dir.delete(path) # fails if path not empty dir
  rescue SystemCallError
    true # nothing, the dir is not empty
  end
  #여기까지

  
  #process :resize_to_fit => [800, 800] #이미지 크기조절

  version :thumb do #이미지 크기조절
    process :resize_to_fill => [200,200]
  end
  
  #공통

     if Rails.env.production?
    storage :fog
  else
    storage :file
end
  def store_dir
    "#{Rails.root}/public/uploads/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
  end

  def extension_white_list #업로드할 수 있는 파일 포맷 지정
    %w(jpg jpeg gif png) # %w, %W 토큰의 배열 (w: 작은 따움표 치환, W: 큰 따움표 치환)
  end
end
