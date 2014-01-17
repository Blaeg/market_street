var MarketStreet = window.MarketStreet || {};

// If we already have the Appointments namespace don't override
if (typeof MarketStreet.Admin == "undefined") {
    MarketStreet.Admin = {};
}
var kk = null;
// If we already have the Appointments object don't override
if (typeof MarketStreet.Admin.products == "undefined") {

    MarketStreet.Admin.products = {
        //scheduled_at    : null,
        initialize      : function( ) {
          // If the user clicks add new variant button
          jQuery('.add_variant_child').live('click', function() {
            MarketStreet.Admin.products.addVariant();// product_table_body
          });
          jQuery('.remove_variant_child').live('click', function() {
            MarketStreet.Admin.products.removeVariant(this);// product_table_body
          });
        },
        addVariant : function(){
          var content =  $('#variants_fields_template').html() ;
          var regexp  = new RegExp('new_variants', 'g');
          var new_id  = new Date().getTime();
          $('#variants_container').append(content.replace(regexp, new_id));
          return false;
        },
        removeVariant : function(obj){
          kk = obj;
          jQuery(obj).closest( '.new_variant_container' ).html('');
        }
    };

    jQuery(function() {
      MarketStreet.Admin.products.initialize();
    });
};
