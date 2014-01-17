class Admin::Fulfillment::InvoicesController < Admin::BaseController
  add_breadcrumb "Invoice", :admin_fulfillment_invoices_path
  include InvoicePrinter

  def index
    @q = Invoice.search(params[:q])
    @invoices = @q.result.includes([:order]).
                  order(sort_column + " " + sort_direction).
                  page(pagination_page).
                  per(pagination_rows)
  end

  def show
    @invoice = Invoice.includes([:order => [
                                            :bill_address,
                                            :ship_address
                                            ]]).find(params[:id])

    respond_to do |format|
      format.html
      format.pdf do
        send_data print_form(@invoice).render, :filename => "invoice_#{@invoice.number}.pdf", :type => 'application/pdf'
      end
    end
  end

  def destroy
    @invoice = Invoice.includes([:order]).find(params[:id])
    redirect_to admin_fulfillment_invoices_url
  end

  def default_sort_column
    "invoices.id"
  end
end
