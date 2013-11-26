SimpleNavigation::Configuration.run do |navigation|
  navigation.active_leaf_class = 'active'
  navigation.items do |primary|
    primary.dom_class = 'nav'
    primary.auto_highlight = true
    primary.item :catalog_tab, 'Catalog', '#' do |catalog|
      catalog.item :products, 'Products', admin_merchandise_products_path
      catalog.item :properties, 'Properties', admin_merchandise_properties_path 
      catalog.item :product_types, 'Product Types', admin_merchandise_product_types_path 
      catalog.item :prototypes, 'Prototypes', admin_merchandise_prototypes_path
      catalog.item :image_groups, 'Image Groups', admin_merchandise_image_groups_path
      catalog.item :brands, 'Brands', admin_merchandise_brands_path
    end

    primary.item :inventory_tab, 'Inventory', admin_inventory_overviews_path do |inventory|
      inventory.item :overview, 'Overviews', admin_inventory_overviews_path
      inventory.item :suppliers, 'Suppliers', admin_inventory_suppliers_path
      inventory.item :receive_po, 'Receive Purchase Order', admin_inventory_receivings_path
      inventory.item :pos, 'Purchase Orders', admin_inventory_purchase_orders_path
      inventory.item :adjusments, 'Adjustments', admin_inventory_adjustments_path 
    end

    primary.item :offer_tab ,"Offer", admin_generic_coupons_path do |offer|        
      offer.item :coupons, 'Coupons', admin_generic_coupons_path
      offer.item :deals,'Deals', admin_generic_deals_path
      offer.item :sales, 'Sales', admin_generic_sales_path
    end

    primary.item :orders_tab, 'Order', admin_history_orders_path do |order|
      order.item :create_order, 'Create Order', admin_shopping_carts_path
      order.item :orders, 'Orders', admin_history_orders_path
      order.item :shipments, 'Shipments', admin_fulfillment_shipments_path
      order.item :invoices, 'Invoices', admin_document_invoices_path
      order.item :fulfillments, 'Fulfillments', admin_fulfillment_orders_path
    end

    primary.item :user_tab ,"User", admin_users_path do |user|
      user.item :users ,"Users", admin_users_path
      user.item :referrals ,"Referrals", admin_user_datas_referrals_path
    end

    if current_user.super_admin?
      primary.item :config_tab ,"Config", admin_config_accounts_path do |config|        
        config.item :accounts, 'Accounts', admin_config_accounts_path 
        config.item :countries,'Countries', admin_config_countries_path
        config.item :shipping_zones, 'Shipping Zones', admin_config_shipping_zones_path
        config.item :shipping_methods, 'Shipping Methods', admin_config_shipping_methods_path
        config.item :shipping_rates, 'Shipping Rates', admin_config_shipping_rates_path 
        config.item :tax_rates, 'Tax Rates', admin_config_tax_rates_path
      end
    end   
  end
end