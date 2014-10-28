source 'https://rubygems.org'

#홈 과정
gem 'rails', '4.1.6'
gem 'sass-rails', '~> 4.0.3'
gem 'uglifier', '>= 1.3.0'
gem 'coffee-rails', '~> 4.0.0'
gem 'jquery-rails'
gem 'turbolinks'
gem 'jbuilder', '~> 2.0'
gem 'sdoc', '~> 0.4.0',          group: :doc
gem 'bootstrap-sass', '3.2.0.2' #Twitter-Bootstrap을 레일스 프로젝트에서 사용하기 쉽게 해주는 젬
gem 'font-awesome-rails', '~> 4.2.0.0'
gem 'jquery-ui-rails', '~> 5.0.0'

#카트과정
gem 'acts_as_shopping_cart', '~> 0.2.1'

#게시판과정
gem 'simple_form' #bootstrap과 함께 form을 사용할 때 잘 어울리는 젬
gem 'acts-as-taggable-on' #태그 젬
gem 'friendly_id', '~> 5.0.0' #id값 대신에 특정 속성값으로 호출을 해주는 젬(ex localhost:3000/bulletin/id=2 대신에 localhost:3000/bulletin/공지사항)



#유저과정
gem 'bcrypt',         '3.1.7'
gem 'faker',          '1.4.2' # make sample users with semi-realistic names and email addresses

#-------------------------------------
gem 'carrierwave',             '0.10.0'
gem 'mini_magick',             '3.8.0'
gem 'fog',                     '1.23.0'
#--------------------------------------- 포스팅 이미지
gem 'will_paginate',           '3.0.7' # 페이징 
gem 'bootstrap-will_paginate', '0.0.10' # 페이징 스타일 in 부트스트랩
gem 'tzinfo-data', platforms: [:mingw, :mswin]

group :test do
  gem 'minitest-reporters', '1.0.5'
  gem 'mini_backtrace',     '0.1.3'
  gem 'guard-minitest',     '2.3.1'
end
group :development do
  gem 'sqlite3', '1.3.9'
  gem 'spring',  '1.1.3'
end
group :production do
  gem 'pg',             '0.17.1'
  gem 'rails_12factor', '0.0.2'
  gem 'unicorn',        '4.8.3'
  
end
