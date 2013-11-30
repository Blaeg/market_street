var MarketStreet = window.MarketStreet || { };
if (typeof MarketStreet.Product == "undefined") {
    MarketStreet.Product = {};
}
dd = null;
if (typeof MarketStreet.Product.tabs == "undefined") {
  MarketStreet.Product.tabs = {
    newFormId : '#new_cart_item',
    addToCart : true,

    initialize      : function() {
      $('#product_tabs .section-container section ').click(function() {
        setTimeout('MarketStreet.Product.tabs.updateProductTabs()', 100);
      })
      $('#product_tabs .section-container .section').first().find('a').click()
      MarketStreet.Product.tabs.updateProductTabs();
    },
    updateProductTabs : function() {
      var heightOfTabContent = $('#product_tabs .section-container .section.active').height();
      if ( heightOfTabContent ) {
        $('#product_tabs .section-container').height(heightOfTabContent + 75);
      } else {
        $('#product_tabs .section-container').height(170);
        setTimeout('MarketStreet.Product.tabs.updateProductTabs()', 200);
      }
    }
  };
  jQuery(function() {
    MarketStreet.Product.tabs.initialize();
  });
};
