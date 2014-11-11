class CartsController < ApplicationController
  before_filter :extract_shopping_cart

  def create
     @product = Product.find(params[:id])
    #@product = Product.first
    @cart.add(@product, @product.price, params[:amount].to_i)

    if params[:option1]
    @item = @cart.cart_items.find_by(item_id: @product.id)
    @item.update_attributes(option: params[:option1], detail: params[:detail1])
    end

    redirect_to cart_path
  
  end

  def show
  end



  def change_qty
   id = params[:id]
   @cart = current_user.cart
   @product = Product.find(id)
   @cart_item = @cart.cart_items.find_by(item_id: id)
   if(params[:type] == 'up')
   @cart.add(@product, @product.price)
   else
    
    @cart.remove(@product) if @cart_item.quantity > 1
    
   end

    @cart_item = @cart.cart_items.find_by(item_id: id)

   respond_to do |format|
      format.html { redirect_to cart_path}
      format.js
    end
end


  def destroy
  @product = Product.find(params[:id])
  # @amount = params[:amount]
  #  # flash[:success] = "#{@product.id}????"
  # # @cart.remove(@product, @amount.to_i)
  quantity = @cart.cart_items.find_by(item_id: @product).quantity
  @cart.remove(@product, quantity)

   redirect_to cart_path
 

  end
 
  def index

  redirect_to root_url
  end
  private
  def extract_shopping_cart
<<<<<<< HEAD
     @user ||= current_user
     @cart = @cart || @user.cart || Cart.create(user_id: current_user.id)
=======
    
     @cart = current_user.cart || Cart.create(user_id: @user.id)
>>>>>>> 11c092afe140312aa746de05257e58c4df0fb3c6
  end


 def update
   
 end

  

end