var MarketStreet = window.MarketStreet || { };
MarketStreet.Product = {}
MarketStreet.Product.tabs = {
  newFormId : '#new_cart_item',
  addToCart : true,

  initialize: function() {
    $('#product_tabs').click(function() {
      e.preventDefault()
      setTimeout('MarketStreet.Product.tabs.updateProductTabs()', 200);        
      $(this).tab('show')
    })

  },    
};

jQuery(function() {
  MarketStreet.Product.tabs.initialize();
});