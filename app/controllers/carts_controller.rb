class CartsController < ApplicationController
  before_filter :extract_shopping_cart
  before_action :mailbox





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
   @cart = current_user.cart
   @product = Product.find(id)
    @cart_item = @cart.cart_items.find_by(item_id: id)
   if(params[:type] == 'up')
   @cart.add(@product, @product.price)
   else
    
    @cart.remove(@product) if @cart_item.quantity > 1
    
   end

    @cart_item = CartItem.where(owner_id = current_user.id , item_id = @product.id)

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

  def mailbox
    @mailbox ||= current_user.mailbox
  end 

end