class Admin::Rma::ReturnAuthorizationsController < Admin::Rma::BaseController
  add_breadcrumb "Order", :admin_history_orders_path
  add_breadcrumb "Return Authorizations", :admin_rma_order_return_authorizations_path
  helper_method :sort_column, :sort_direction
  before_filter :current_order
  
  def index
    @q = ReturnAuthorization.search(params[:q])
    @return_authorizations = @q.result
  end

  def show
    @return_authorization = ReturnAuthorization.find(params[:id])
  end

  def new
    @return_authorization = ReturnAuthorization.new
    comment = Comment.new()
    comment.user_id = current_order.user_id
    comment.created_by = current_user.id
    @return_authorization.comments << (comment)
    form_info
  end

  def edit
    @return_authorization = ReturnAuthorization.includes(:comments).find(params[:id])
    form_info
  end

  def create
    @return_authorization = current_order.return_authorizations.new(allowed_params)
    @return_authorization.created_by = current_user.id
    @return_authorization.user_id = current_order.user_id

    if @return_authorization.save
      redirect_to(admin_rma_order_return_authorization_url(current_order, @return_authorization), :notice => 'Return authorization was successfully created.')
    else
      form_info
      render :action => "new"
    end
  end

  def update
    @return_authorization = ReturnAuthorization.find(params[:id])

    if @return_authorization.update_attributes(allowed_params)
      redirect_to(admin_rma_order_return_authorization_url(current_order, @return_authorization), :notice => 'Return authorization was successfully updated.')
    else
      form_info
      render :action => "edit"
    end
  end

  def complete
    @return_authorization = ReturnAuthorization.find(params[:id])
    if @return_authorization.complete!
      flash[:notice] = 'This RMA is complete.'
    else
      flash[:error] = 'Something when wrong!'
    end

    render :action => 'show'
  end
  
  def destroy
    @return_authorization = ReturnAuthorization.find(params[:id])

    if @return_authorization.cancel!
      redirect_to(admin_rma_order_return_authorization_url(current_order, @return_authorization), :notice => 'Return authorization was successfully updated.')
    else
      flash[:notice] = 'Return authorization had an error.'
      form_info
      render :action => "edit"
    end
  end
  
  private
  
  def current_order
    @order = Order.includes([:ship_address, :invoices,
               {:shipments => :shipping_method},
               {:order_items => [ {:variant => [:product, :variant_properties]}]
                }]).find(params[:order_id])
  end

  def allowed_params
    params.require(:return_authorization).permit( :amount, :restocking_fee, :order_id, :active)
  end

  def form_info
    @return_conditions  = ReturnItem.select_conditions_form
    @return_reasons     = ReturnItem.select_reasons_form
  end

  def sort_column
    return 'users.last_name' if params[:sort] == 'user_name'
    ReturnAuthorization.column_names.include?(params[:sort]) ? params[:sort] : "id"
  end

  def sort_direction
    %w[asc desc].include?(params[:direction]) ? params[:direction] : "asc"
  end
end