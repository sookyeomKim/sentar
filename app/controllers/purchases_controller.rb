 class PurchasesController < ApplicationController
  before_action :set_purchase, only: [:show,  :update, :edit, :destroy ]
  

  # GET /purchases
  # GET /purchases.json
  def index
    @purchases = Purchase.all
  end

  # GET /purchases/1
  # GET /purchases/1.json
  def show
  end

  # GET /purchases/new
  def new
    order = params[:order]
    if order == 'goods' 
    @option = params[:option1]
    @detail = params[:detail1]
    @product = Product.find(params[:id])
    @purchase = @product.purchases.new(user_id: current_user.id, total_cost: @product.price)
    if (quantity = params[:quantity1].to_i)
    
      @purchase.quantity = quantity
      @purchase.total_cost *= quantity
    end
  

    else
    if current_user.cart.total == 0
    flash[:danger] = "상품이 없습니다"
    redirect_to cart_path 
    end
    @purchase = Purchase.new
    end
    
  end

  # GET /purchases/1/edit
  def edit
    
  end

  # POST /purchases
  # POST /purchases.json
  def create
    @order_info = Purchase.new(purchase_params)
    
    unless @order_info.ordertype == 'cart'
    @purchase = @order_info
    set_rest
    respond_to do |format|
      if @purchase.save

        
        title = "#{current_user.name}님이 상품(#{@purchase.product.name})을 구매하였습니다 "
        message = "#{current_user.name}님이 상품#{@purchase.product.name}을 구매하였습니다 " + "<a href ='/sell_list'>보러가기</a> "
        Pusher.trigger("mychannel-#{@purchase.product.user.id}", 'my-event', {:type => "new_purchase", :title=>title , :message => message, :url => current_user.gravatar_url } )
        @purchase.product.user.notify("#{current_user.name}님이 상품(#{@purchase.product.name})을 구매하였습니다", "/sell_list" )
        product = @purchase.product
        product.update_attributes(quantity: product.quantity - 1 , sell_count: product.sell_count + 1)
        # format.html { redirect_to @purchase, notice: 'Purchase was successfully created.' }
        format.html { redirect_to order_ok_path(type: 'goods', id:@purchase.id)}
        format.json { render :show, status: :created, location: @purchase }
      else
        format.html { render :new }
        format.json { render json: @purchase.errors, status: :unprocessable_entity }
      end
    end
  else
    @cart_items = current_user.cart.cart_items
    order_info = Purchase.new(purchase_params)
    @cart_items.each do |cart_item|
      @product = cart_item.product
      @purchase = @product.purchases.new(user_id: current_user.id, total_cost: cart_item.quantity * cart_item.price)
      @purchase.receive_name = order_info.receive_name
      @purchase.addr = order_info.addr
      @purchase.phone = order_info.phone
      @purchase.memo = order_info.memo
      @purchase.ordertype = 'cart'
      @purchase.quantity = cart_item.quantity
      @purchase.option = cart_item.option
      @purchase.detail = cart_item.detail
      set_rest
      if @purchase.save
        title = "#{current_user.name}님이 상품(#{@purchase.product.name})을 구매하였습니다 "
        message = "#{current_user.name}님이 상품#{@purchase.product.name}을 구매하였습니다 " + "<a href ='/sell_list'>보러가기</a> "
        Pusher.trigger("mychannel-#{@purchase.product.user.id}", 'my-event', {:type => "new_purchase", :title=>title , :message => message, :url => current_user.gravatar_url } )
        @purchase.product.user.notify("#{current_user.name}님이 상품(#{@purchase.product.name})을 구매하였습니다", "/sell_list" )
        @product.update_attributes(quantity: @product.quantity - 1 , sell_count: @product.sell_count + @purchase.quantity)
      end
    end
   
    redirect_to order_ok_path(type: 'cart')
  end


  end

  def order_ok
    if params[:type] == 'goods'
      purchase = Purchase.find(params[:id])
      @total = purchase.total_cost
      
     else #for order from cart
      @total = current_user.cart.total
       current_user.cart.clear #cart clear
    end
    
  end

  def cancel


    @purchase = Purchase.find(params[:id])
    @purchase.update_attribute(:status, 5)
   redirect_to buy_list_path

  end


  # PATCH/PUT /purchases/1
  # PATCH/PUT /purchases/1.json
  def update
    respond_to do |format|
      if @purchase.update(purchase_params)
        format.html { redirect_to @purchase, notice: '상품이 변경 되었습니다.' }
        format.json { render :show, status: :ok, location: @purchase }
      else
        format.html { render :edit }
        format.json { render json: @purchase.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /purchases/1
  # DELETE /purchases/1.json
  def destroy
    @purchase.destroy
    respond_to do |format|

      format.html { redirect_to sell_list_path, notice: '주문이 삭제되었습니다.' }
      format.json { head :no_content }
    end
  end

  private
    
    # Use callbacks to share common setup or constraints between actions.
    def set_purchase
      @purchase = Purchase.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def purchase_params
       params.require(:purchase).permit(:product_id, :user_id, :receive_name, :addr, :phone, :memo, :total_cost, :trade_type, :payer, :status, :ship_cost, :ship_company,
        :trans_num, :quantity, :ordertype, :option, :detail)
     
    end
    def set_rest
      @purchase.status = 0
      @purchase.owener_id = @purchase.product.user_id
    end
end
