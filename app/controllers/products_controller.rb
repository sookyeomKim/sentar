class ProductsController < ApplicationController
	before_action :set_product , only: [:correct_user, :show, :edit, :update]
	before_action :logged_in_user, only: [:create, :destroy]
	before_action :correct_user, only: [ :destroy, :edit]

	
	def show

	end

	def new
	@product = Product.new
	end

	def index
		@user ||= current_user
		@products = @user.products.paginate(page: params[:page])
	end

	#def myindex
	#	@user = User.find(current_user)
	#	@products = @user.products.paginate(page: params[:page])
	#end
		
	def edit

	end

	def sell_list

	 end

	
	def create
	@user ||= current_user
    	@product = @user.products.build(product_params)
    	@product.sell_count = 0
     
        
    	

      respond_to do |format|

    	  if @product.save


        
        if @product.option1 
        @option = @product.options.build(name: @product.option1)
        if @option.save
        @details =@product.detail1.split(",")
        @details.each do |detail| 
        @option.details.new(name: detail).save
        end
        end
      end

     if @product.option2
        @option = @product.options.build(name: @product.option2)
        if @option.save
        @details =@product.detail2.split(",")
        @details.each do |detail| 
        @option.details.new(name: detail).save
        end
        end
      end
        
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
     CartItem.rm_product_incart(@product)

  
  	redirect_to products_path	
  	end


  	def update
  	 respond_to do |format|
      if @product.update(product_params)
        format.html { redirect_to products_path, notice: '수정 되었습니다.' }
        #format.json { render :show, status: :ok, location: @product }
      else
        format.html { render :edit }
        #format.json { render json: @product.errors, status: :unprocessable_entity }
      end
    end
  		
  	end

 private
   

  def correct_user
   set_product
   redirect_to(products_path) unless current_user?(@product.user)
  end

  def product_params
      params.require(:product).permit(:name, :price, :picture, :category, :content, :picture2, :picture3, :quantity , :option1, :detail1, :option2, :detail2)
    end

    def	set_product
    @product = Product.find(params[:id])

    end

end
