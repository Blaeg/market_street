var MarketStreet = window.MarketStreet || {};

// If we already have the Admin namespace don't override
if (typeof MarketStreet.Admin == "undefined") {
    MarketStreet.Admin = {};
}
var kk = null;
// If we already have the purchaseOrder object don't override
if (typeof MarketStreet.Admin.properties == "undefined") {

    MarketStreet.Admin.properties = {
        //test    : null,
        initialize      : function( ) {
          // jQuery(".chzn-select").chosen();
          jQuery(".chzn-select").data("placeholder","Select Properties...").chosen();
        }
    };

    jQuery(function() {
      MarketStreet.Admin.properties.initialize();
    });
}
