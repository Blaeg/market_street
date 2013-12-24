class Admin::CustomerService::CommentsController < Admin::CustomerService::BaseController
  add_breadcrumb "Comments", :admin_customer_service_user_comments_path
  helper_method :sort_column, :sort_direction, :customer

  def index
    @comments = customer.comments.order(sort_column + " " + sort_direction).
                  page(pagination_page).per(pagination_rows)                                  
  end

  def show
    @comment = customer.comments.find(params[:id])
  end

  def new
    @comment = customer.comments.new
  end

  def create
    @comment = current_user.customer_service_comments.new(allowed_params)
    @comment.user_id = customer.id
    @comment.created_by = current_user.id
    if @comment.save
      redirect_to [:admin, :customer_service, customer, @comment], :notice => "Successfully created comment."
    else
      render :new
    end
  end

  def default_sort_column
    "comments.note"
  end  

  private

  def allowed_params
    params.require(:comment).permit(:note)
  end

  def customer
    @customer ||= User.find(params[:user_id])
  end
end
