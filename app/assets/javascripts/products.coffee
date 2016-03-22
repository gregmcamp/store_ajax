$(document).ready ->
  baseUrl = 'http://devpoint-ajax-example-server.herokuapp.com/api/v1/products'
  if location.pathname == '/'
    $.ajax
      url: baseUrl
      type: 'GET'
      dataType: 'JSON'
      success: (data) ->
        tbody = $('#products')
        data.products.forEach (product) ->
          price = if product.base_price then product.base_price else '0'
          description = if product.description then product.description else ''
          row = '<tr><td>' + product.name + '</td>'
          row += '<td>$' + price + '</td>'
          row += '<td>' + description + '</td>'
          row += '<td><button data-id="' + product.id + '" class="btn btn-primary">Show</button></td></tr>'
          tbody.append row
          return
        return
      error: (error) ->
        console.log error
        return
    $(document).on 'click', '.btn', ->
      id = @dataset.id
      location.href = '/products/' + id
      return
  re = /\/products\/\d+/
  if location.pathname.match(re)
    panel = $('#panel')
    id = panel.data('id')
    $.ajax
      url: baseUrl + '/' + id
      type: 'GET'
      dataType: 'JSON'
      success: (data) ->
        product = data.product
        panel.children('#heading').html product.name
        list = '<li>Price: $' + product.base_price + '</li>'
        description = '<li>Description: ' + product.description + '</li>'
        remove = '<li><button class="btn btn-danger" id="remove"> Delete</button></li>'
        list.append price
        list.append description
        list.append remove
        return
    $(document).on 'click', '#remove', ->
      $.ajax
        url: baseUrl + '/' + id
        type: 'DELETE'
        success: ->
          location.href = '/'
          return
      return
  $('#add_product').on 'submit', (e) ->
    e.preventDefault()
    $.ajax
      url: baseUrl
      type: 'POST'
      dataType: 'JSON'
      data: $(this).serializeArray()
      success: (data) ->
        console.log data.product
        location.href = '/'
        return
    return
  return
