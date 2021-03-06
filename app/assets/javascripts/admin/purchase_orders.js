var MarketStreet = window.MarketStreet || {};

// If we already have the Admin namespace don't override
if (typeof MarketStreet.Admin == "undefined") {
    MarketStreet.Admin = {};
}

// If we already have the purchaseOrder object don't override
if (typeof MarketStreet.Admin.purchaseOrder == "undefined") {

    MarketStreet.Admin.purchaseOrder = {
        //test    : null,
        initialize      : function( ) {
          jQuery(".chzn-select").chosen();

          jQuery('.add_variant').bind('click', function(){
            var assoc = $(this).attr('data-association');
            var content = $('#' + assoc + '_fields_template').html();
            var regexp = new RegExp('new_' + assoc, 'g');
            var new_id = new Date().getTime();
            $(this).parent().before(content.replace(regexp, new_id));
            jQuery('#purchase_order_purchase_order_variants_attributes_'+ new_id +'_variant_id').addClass('chzn-select');
            jQuery(".chzn-select").chosen();
            return false;
          });

          jQuery('.select_variants').live('change', function(){
            //alert($(this).val());
            MarketStreet.Admin.purchaseOrder.prefillCost(this);
            return false;
          });
        },
        prefillCost : function(obj) {
          jQuery.ajax( {
             type : "GET",
             url : "/admin/catalog/products/"+ 0 +"/variants/"+ $(obj).val(),
             complete : function(json) {
              variant = JSON.parse(json.responseText).variant;
              variant.cost;
              $('#'+ obj.id.replace("variant_id", "cost")).val(variant.cost);
             },
             dataType : 'json'
          });
        }
    };

    jQuery(function() {
      MarketStreet.Admin.purchaseOrder.initialize();
    });
}
