$(document).ready(function() {
  var baseUrl = 'http://devpoint-ajax-example-server.herokuapp.com/api/v1/products';
  if (location.pathname === '/') {
    $.ajax({
      url: baseUrl,
      type: 'GET',
      dataType: 'JSON',
      success: function(data) {
        var tbody = $('#products');
        data.products.forEach( function(product) {
          var price = product.base_price ? product.base_price: '0';
          var description = product.description ? product.description: '';
          var row = '<tr><td>' + product.name + '</td>';
                row += '<td>$' + price + '</td>';
                row += '<td>' + description + '</td>';
                row += '<td><button data-id="' + product.id + '" class="btn btn-primary">Show</button></td></tr>'
            tbody.append(row);
          });
        },
          error: function(error){
            console.log(error);
          }
        });

        $(document).on('click', '.btn', function() {
          var id = this.dataset.id;
          location.href = '/products/' + id;
        });


      }
      var re = /\/products\/\d+/;
      if (location.pathname.match(re)) {
        var panel = $('#panel');
        var id = panel.data('id');
        $.ajax({
          url: baseUrl + '/' + id,
          type: 'GET',
          dataType: 'JSON',
          success: function(data){
            var product = data.product;
            panel.children('#heading').html(product.name);
            var list = '<li>Price: $' + product.base_price + '</li>';
            var description = '<li>Description: ' + product.description + '</li>';
            var remove = '<li><button class="btn btn-danger" id="remove"> Delete</button></li>';

            list.append(price);
            list.append(description);
            list.append(remove);
          }
        });

        $(document).on('click','#remove', function(){
          $.ajax({
            url:baseUrl + '/' + id,
            type: 'DELETE',
            success: function(){
              location.href = '/';
            }
          });
    });

}
  $('#add_product').on('submit',function(e){
    e.preventDefault();
    $.ajax({
      url: baseUrl,
      type: 'POST',
      dataType: 'JSON',
      data: $(this).serializeArray(),
      success: function(data) {
        console.log(data.product);
        location.href = '/';
      }
    });
  });
});
