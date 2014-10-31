class CartsController < ApplicationController
  before_filter :extract_shopping_cart

  def create
     @product = Product.find(params[:id])
    #@product = Product.first
    @cart.add(@product, @product.price, params[:amount].to_i)
    redirect_to cart_path
  
  end

  def show
  end



  def change_qty
   id = params[:id]
   qty = params[:qty]
   
   @cart = current_user.cart
   @product = Product.find(id)
   @cart.add(@product, 99)


   respond_to do |format|
      format.js #make_a_change.js.erb
   end
end


  def destroy
  @product = Product.find(params[:id])
  # @amount = params[:amount]
  #  # flash[:success] = "#{@product.id}????"
  # # @cart.remove(@product, @amount.to_i)
  # @cart.remove(@product)

  CartItem.rm_product_incart(@product)
   redirect_to cart_path
 

  end
 
  def index

  redirect_to root_url
  end
  private
  def extract_shopping_cart
     @user = User.find(current_user.id)
     @cart = Cart.find_by(user_id: @user.id) || Cart.create(user_id: @user.id)
  end

 def update
   
 end
end