var MarketStreet = window.MarketStreet || { };
MarketStreet.Cart = {};
MarketStreet.Cart.newForm = {
  newFormId : '#new_cart_item',
  addToCart : true,

  initialize: function() {
    $('#submit_add_to_cart').click( function() {
      if (MarketStreet.Cart.newForm.addToCart) {
          MarketStreet.Cart.newForm.addToCart = false;// ensure no double clicking
          jQuery(MarketStreet.Cart.newForm.newFormId).submit();
      }
    });

    $('.variant_select').click( function() {
        $('.variant_properties').each( function(index, obj) {
          $(obj).removeClass('selected');
        });

        var propId = '#variant_properties_' + $(this).data("variant_id");
      $( propId ).addClass('selected');
        $('#cart_item_variant_id').val($(this).data("variant_id"));
        $(".variant_select").removeClass('selected_variant');
        $(this).addClass('selected_variant');        
      }
    );

    $( ".cart_item_quantity" ).change(function() {
      var cartItemId = $(this).attr('data-cart-item-id');
      var form = $('#edit_cart_item_'+cartItemId);

      $.ajax({ 
        type: "POST",  
        url: form.attr("action"),  
        data: form.serializeArray(),
        success: function() { /*location.reload();*/ },
        error: function() { alert('failure'); }
      });  
      return false;
    });

    //select address
    $( "#cart_ship_address_id" ).change(function() {
      var form = $('#cart_ship_address_id');
      $.ajax({ 
        type: "PUT",  
        url: '/shopping/carts',  
        data: form.serializeArray(),
        success: function() { /*location.reload();*/ },
        error: function() { alert('failure');}
      });  
      return false;
    });
    
    $( "#cart_bill_address_id" ).change(function() {
      var form = $('#cart_bill_address_id');
      $.ajax({ 
        type: "PUT",  
        url: '/shopping/carts',  
        data: form.serializeArray(),
        success: function() { /*location.reload();*/ },
        error: function() { alert('failure'); }
      });  
      return false;
    });

    //checkout tabs
    $('#checkoutTab a').click(function (e) {
      e.preventDefault();
      $(this).tab('show');
    })

    //select address
    $('.selectpicker').selectpicker();
  }
};

jQuery(function() {
  MarketStreet.Cart.newForm.initialize();
});