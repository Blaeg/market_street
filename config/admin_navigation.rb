SimpleNavigation::Configuration.run do |navigation|
  navigation.active_leaf_class = 'active'
  navigation.items do |primary|
    primary.item :catalog_tab, 'Catalog', admin_merchandise_products_path do |catalog|
      catalog.item :products_link, 'Products', admin_merchandise_products_path
      catalog.item :properties_link, 'Properties', admin_merchandise_properties_path 
      catalog.item :product_types_link, 'Product Types', admin_merchandise_product_types_path 
      catalog.item :prototypes_link, 'Prototypes', admin_merchandise_prototypes_path
      catalog.item :image_group_link, 'Image Groups', admin_merchandise_image_groups_path
      catalog.item :brands_link, 'Brands', admin_merchandise_brands_path
    end

    primary.item :inventory_tab, 'Inventory', admin_inventory_overviews_path do |inventory|
      inventory.item :overview_link, 'Overviews', admin_inventory_overviews_path
      inventory.item :supplier_link, 'Suppliers', admin_inventory_suppliers_path
      inventory.item :receive_po_link, 'Receive Purchase Order', admin_inventory_receivings_path
      inventory.item :pos_link, 'Purchase Orders', admin_inventory_purchase_orders_path
      inventory.item :adjusments_link, 'Adjustments', admin_inventory_adjustments_path 
    end

    primary.item :offer_tab ,"Offer", admin_generic_coupons_path do |offer|        
      offer.item :coupin_link, 'Coupons', admin_generic_coupons_path
      offer.item :deal_link,'Deals', admin_generic_deals_path
      offer.item :sales_link, 'Sales', admin_generic_sales_path
    end

    primary.item :orders_tab, 'Order', admin_history_orders_path do |order|
      order.item :create_order_link, 'Create Order', admin_shopping_carts_path
      order.item :old_orders_link, 'Orders', admin_history_orders_path
      order.item :shipment_link, 'Shipments', admin_fulfillment_shipments_path
      order.item :invoice_link, 'Invoices', admin_document_invoices_path
      order.item :fulfill_link, 'Fulfillments', admin_fulfillment_orders_path
    end

    primary.item :user_tab ,"User", admin_users_path do |user|
      user.item :users_link ,"Users", admin_users_path
      user.item :referrals_link ,"Referrals", admin_user_datas_referrals_path
    end

    if current_user.super_admin?
      primary.item :config_tab ,"Config", admin_config_accounts_path do |config|        
        config.item :account_link, 'Accounts', admin_config_accounts_path 
        config.item :country_link,'Countries', admin_config_countries_path
        config.item :shipping_zone_link, 'Shipping Zones', admin_config_shipping_zones_path
        config.item :shipping_method_link, 'Shipping Methods', admin_config_shipping_methods_path
        config.item :shipping_rate_link, 'Shipping Rates', admin_config_shipping_rates_path 
        config.item :tax_rate_link, 'Tax Rates', admin_config_tax_rates_path
      end
    end
    
    primary.dom_class = 'nav'
    primary.auto_highlight = true
  end
end