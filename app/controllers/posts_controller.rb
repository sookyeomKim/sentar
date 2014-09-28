#기본 게시판 형태의 컨트롤러
class PostsController < ApplicationController
  #레일스 4부터 _filter가 _action으로 변경
  before_action :set_bulletin#모든 액션 수행전에 수행됨
  before_action :set_post, only: [:show, :edit, :update, :destroy]#posts 컨트롤러의 액션 중에서 show, edit,update, destroy 액션이 실행되기 전에 반드시 set_post 메소드를 실행하라는 필터
  #before_action에 지정된 메서드는 지정된 액션이 실행되기 전에만 수행됨.

  # GET /posts
  # GET /posts.json
  def index #DB 쿼리후, 특정 모델(들)의 모든 객체를 불러와 보여 준다
    #@posts = Post.all
    #@posts = @bulletin.posts.all#인스턴스 변수 @posts를 생성, 이것은 해당 뷰 템플릿(app/views/posts/index.html.erb)에서 바로 사용
    
    if params[:bulletin_id]#태그값이 넘어왔는지 bulletin_id값이 넘어왔는지 판단하에 인스턴스 생성
      @posts = @bulletin.posts.all
    else
      if params[:tag]
        @posts = Post.tagged_with(params[:tag])#Post.tagged_with() 클래스 메소드는 acts-as-taggable-on 젬이 지원한 메소드로 임의의 태그를 넘겨 주면 해당 태그를 포함하는 post 객체들을 반환해 준다.
      else
        @posts = Post.all
      end
    end
  end

  # GET /posts/1
  # GET /posts/1.json
  def show #DB 쿼리후, 특정 모델의 특정 객체만을 불러와 보여 준다.
  end

  # GET /posts/new
  def new #데이터 조작을 하지 않고 단지 뷰를 렌더링하는 기능만을 가진다
    #@post = Post.new
    @post = @bulletin.posts.new
  end#새로운 데이터를 입력 받는 폼을 응답으로 보낸다.

  # GET /posts/1/edit
  def edit #데이터 조작을 하지 않고 단지 뷰를 렌더링하는 기능만을 가진다
  end#기존 데이터를 수정하기 위한 폼을 응답으로 보낸다.

  # POST /posts
  # POST /posts.json
  def create #특정 모델의 한 객체를 생성하여 DB 테이블로 저장한다. 액션 종료시 show 액션으로 리디렉트
    #@post = Post.new(post_params)
    @post = @bulletin.posts.new(post_params)
    
    respond_to do |format|
      if @post.save
        #format.html { redirect_to @post, notice: 'Post was successfully created.' }
        format.html { redirect_to [@post.bulletin, @post], notice: 'Post was successfully created.' }#post가 bulletin의 id값을 foregin key로 소유하고 있음.
        format.json { render :show, status: :created, location: @post }
      else
        format.html { render :new }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
    
  end

  # PATCH/PUT /posts/1
  # PATCH/PUT /posts/1.json
  def update #DB 쿼리후, 특정 모델의 속성을 변경한 후 DB 테이블로 저장한다. 액션 종료시 show 액션으로 리디렉트된다.
    respond_to do |format|
      if @post.update(post_params)
        #format.html { redirect_to @post, notice: 'Post was successfully updated.' }
        format.html { redirect_to [@post.bulletin, @post], notice: 'Post was successfully updated.' }
        format.json { render :show, status: :ok, location: @post }
      else
        format.html { render :edit }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
    
  end

  # DELETE /posts/1
  # DELETE /posts/1.json
  def destroy #DB 쿼리후, 특정 모델의 특정 객체(들)를 삭제한다. 액선 종류시 index 액션으로 리디렉트된다.
    @post.destroy
    respond_to do |format|
      #format.html { redirect_to posts_url, notice: 'Post was successfully destroyed.' }
      format.html { redirect_to bulletin_posts_url, notice: 'Post was successfully destroyed.' }#Prefix끝에 _url이나 _path를 붙여서 helper메서드로 사용,
                                                                                                #뷰 템플릿에서 동적 URL을 사용할 수 있도록 해 주어 정적 URL을 일일이 입력할 필요가 없게 된다.
                                                                                                #즉, 뷰 템플릿 파일에서 <%= bulletin_posts_path('공지사항') %>와 같이 사용하면
                                                                                                #뷰 파일이 렌더링될 때 http://localhost:3000/bulletins/공지사항/posts으로 변환된다.
      format.json { head :no_content }
    end
  end

  private 
    
    def set_bulletin #모든 액션 실행전에 수행됨
      @bulletin = Bulletin.friendly.find(params[:bulletin_id]) if params[:bulletin_id]#friendly젬 추가(id값 대신에 다른 속성값을 받을거기 때문에)
    end
    
    def set_post #지정 액션 실행전에만 수행됨
      #@post = Post.find(params[:id])#파라미터로 넘겨 받은 id 값을 이용하여 특정 post를 조회한 후 @post 인스턴스 변수에 할당
      #@post = @bulletin.posts.find(params[:id])#bulletin에 연결된 post를 찾음
      
      if params[:bulletin_id]#tag로 index 호출시 :tag파라미터만 넘겨오는 경우
        @post = @bulletin.posts.find(params[:id])
      else
        @post = Post.find(params[:id])
      end
    end

    def post_params#레일스 4로 업그레이드되면서 속성 보안관련 기능이 모델로부터 컨트롤러로 이동하여 Strong Parameters의 개념으로 재구성
      #params.require(:post).permit(:title, :content)#파라미터로 넘겨 받은 속성 중에 title과 content만을 화이트리스트로 인정하겠다는 뜻이다. 따라서 다른 속성은 save 또는 udpate 되지 않게 된다.
      params.require(:post).permit(:title, :content, :picture, :picture_cache, :tag_list)#게시판 형태에 따른 view를 보여주기 위해 화이트리스트를 추가하였다.
    end#레일스 3에서는 mass assignment에 대한 화이트리스트를 해당 모델 클래스에서 attr_accesible 매크로로 작성. ex)attr_accessible :title, :content
end
