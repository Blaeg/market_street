SimpleNavigation::Configuration.run do |navigation|
  navigation.active_leaf_class = 'active'
  
  navigation.items do |primary|
    primary.item :user_tab ,"Customer", '#', icon: ['fa fa-users'] do |customer|
      customer.item :users_link ,"Users", admin_customer_users_path
      customer.item :referrals_link ,"Referrals", admin_customer_referrals_path
    end

    primary.item :catalog_tab, 'Catalog', '#', icon: ['fa fa-shopping-cart']  do |catalog|
      catalog.item :products_link, 'Products', admin_catalog_products_path
      catalog.item :properties_link, 'Properties', admin_catalog_properties_path 
      catalog.item :product_types_link, 'Product Types', admin_catalog_product_types_path 
      catalog.item :prototypes_link, 'Prototypes', admin_catalog_prototypes_path      
    end

    primary.item :inventory_tab, 'Inventory', '#', icon: ['fa fa-truck']  do |inventory|
      inventory.item :overview_link, 'Overviews', admin_inventory_overviews_path
      inventory.item :suppliers_link, 'Suppliers', admin_inventory_suppliers_path
      inventory.item :receive_po_link, 'Receive Purchase Order', admin_inventory_receivings_path
      inventory.item :pos_link, 'Purchase Orders', admin_inventory_purchase_orders_path
      inventory.item :adjusments_link, 'Adjustments', admin_inventory_adjustments_path 
    end

    primary.item :offer_tab ,"Offer", '#', icon: ['fa fa-tags']  do |offer|        
      offer.item :coupons_link, 'Coupons', admin_offer_coupons_path
      offer.item :deals_link,'Deals', admin_offer_deals_path
      offer.item :sales_link, 'Sales', admin_offer_sales_path
    end

    primary.item :orders_tab, 'Order', '#', icon: ['fa fa-credit-card']  do |order|
      order.item :orders_link, 'Orders', admin_history_orders_path
      order.item :shipments_link, 'Shipments', admin_fulfillment_shipments_path
      order.item :invoices_link, 'Invoices', admin_fulfillment_invoices_path
      order.item :fulfillments_link, 'Fulfillments', admin_fulfillment_orders_path
    end

    if current_user.super_admin?
      primary.item :config_tab ,"Config", '#', icon: ['fa fa-gear']  do |config|        
        config.item :shipping_zones_link, 'Shipping Zones', admin_config_shipping_zones_path
        config.item :shipping_methods_link, 'Shipping Methods', admin_config_shipping_methods_path
        config.item :shipping_rates_link, 'Shipping Rates', admin_config_shipping_rates_path 
        config.item :tax_rates_link, 'Tax Rates', admin_config_tax_rates_path
        config.item :countries_link,'Countries', admin_config_countries_path        
      end
    end   

    primary.dom_class = 'nav'
    primary.auto_highlight = true    
  end
end