class Admin::Fulfillment::AddressesController < Admin::Fulfillment::BaseController
  add_breadcrumb "Shipping /Address", :admin_fulfillment_shipments_path
  before_filter :shipment

  # GET /admin/fulfillment/addresses/1/edit
  def edit
    @addresses  = @shipment.shipping_addresses
    @address = Address.find(params[:id])
  end

  # PUT /admin/fulfillment/addresses/1
  def update
    @address = Address.find(params[:id])

    @shipment.address = @address
    @shipment.save
    redirect_to(admin_fulfillment_shipments_path(:order_id => @shipment.order_id), 
      :notice => 'Shipping address was successfully selected.')
  end

  private

  def shipment
    @shipment = Shipment.find_fulfillment_shipment(params[:shipment_id])
  end
end
