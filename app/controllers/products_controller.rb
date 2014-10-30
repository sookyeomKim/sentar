class ProductsController < ApplicationController
	before_action :logged_in_user, only: [:create, :destroy]
	before_action :correct_user, only: [ :destroy]
	
	def show
	@product = Product.find(params[:id])
	@comment = @product.comments.build	 
	end

	def new
	@product = Product.new
	end

	def index
		@user = current_user
		@products = @user.products.paginate(page: params[:page])
	end

	def myindex
		@user = User.find(current_user)
		@products = @user.products.paginate(page: params[:page])
	end
		
	

	def sell_list

	 end

	
	def create
	@user = current_user
    	@product = @user.products.build(product_params)


    	respond_to do |format|
    	  if @product.save
    	   flash[:success] = "상품이 등록 되었습니다."
        format.html { redirect_to products_path }
        format.json { render :show, status: :created, location: @product }
      else
        format.html { render :new }
        format.json { render json: @product.errors, status: :unprocessable_entity }
      end
     end
     end

  	def destroy	
  	@product.update_attribute(:user_id, nil)
  	@cart_items = CartItem.where(item_id: @product.id)
  	@cart_items.each  do |item|
  		item.destroy
  	end
  	redirect_to products_path	
  	end

 	private


  def correct_user
  @product = Product.find(params[:id])
   redirect_to(products_path) unless current_user?(@product.user)
  end

  def product_params
      params.require(:product).permit(:name, :price, :picture, :category, :content, :picture2, :picture3)
    end

end
