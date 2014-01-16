var MarketStreet = window.MarketStreet || { };
if (typeof MarketStreet.Product == "undefined") {
    MarketStreet.Product = {};
}
if (typeof MarketStreet.Product.tabs == "undefined") {
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
};
