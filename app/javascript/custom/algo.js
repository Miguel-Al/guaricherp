document.addEventListener("turbolinks:load", function() {
  $("#buscador_productos").keyup(function(event){
      let termino = $(this).val();
      let id_modelo = $(this).data("model");
      let tipo_modelo = $(this).data("tipo");
      if(termino.length == 0) {
          $("#tabla_buscador tbody").empty();
      }
      else {
        request_url = getRootUrl() + "/buscador_productos/" + termino;
        $.get(request_url, function(data, status){
          if(data.length > 0)  {
              $("#tabla_buscador tbody").empty();
              for(x in data){
                let nombre_producto = data[x].nombre_producto;
                  let existencia_producto = data[x].existencia_producto;
		  let precio_producto = data[x].precio_producto;
                let id_producto = data[x].id;
                newRowContent = `<tr>
                                    <td>${nombre_producto}</td>
                                    <td>${existencia_producto}</td>
                                    <td>$${precio_producto}</td>
                                    <td><button type="button" class="btn btn-primary" onclick="seleccionarProducto(${id_producto}, ${id_modelo}, '${tipo_modelo}')">
                                        Agregar
                                        </button>
                                    </td>
                                 </tr>`;
                $("#tabla_buscador tbody").append(newRowContent);
              }
          }
        });
      }
  });

    $("#buscador_productoscompra").keyup(function(event){
      let termino = $(this).val();
      let id_modelo = $(this).data("model");
      let tipo_modelo = $(this).data("tipo");
      if(termino.length == 0) {
          $("#tabla_buscadorcompra tbody").empty();
      }
      else {
        request_url = getRootUrl() + "/buscador_productoscompra/" + termino;
        $.get(request_url, function(data, status){
          if(data.length > 0)  {
              $("#tabla_buscadorcompra tbody").empty();
              for(x in data){
                let nombre_producto = data[x].nombre_producto;
                  let existencia_producto = data[x].existencia_producto;
                let id_producto = data[x].id;
                newRowContent = `<tr>
                                    <td>${nombre_producto}</td>
                                    <td>${existencia_producto}</td>
                                    <td><button type="button" class="btn btn-primary" onclick="seleccionarProducto(${id_producto}, ${id_modelo}, '${tipo_modelo}')">
                                        Agregar
                                        </button>
                                    </td>
                                 </tr>`;
                $("#tabla_buscadorcompra tbody").append(newRowContent);
              }
          }
        });
      }
  });

    $("#buscador_clientes").keyup(function(event){
    let termino = $(this).val();
    let id_venta = $(this).data("venta");
    if(termino.length == 0) {
      $("#tabla_buscador_clientes tbody").empty();
    }
    else {
      let request_url = getRootUrl() + "/buscador_clientes/" + termino;
      $.get(request_url, function(data, status){
        if(data.length > 0){
          $("#tabla_buscador_clientes tbody").empty();
          for(x in data){
            let nombre = data[x].nombre_cliente;
            let id_cliente = data[x].id;
            let rowContent = `
               <tr>
                 <td>${nombre}</td>
                 <td>
                     <button 
                       class = "btn btn-primary"
                       onclick="seleccionarCliente(${id_cliente}, ${id_venta})"
                       >
                         Agregar
                     </button>
                 </td>
               </tr>
            `;
            $("#tabla_buscador_clientes tbody").append(rowContent);
          }
        }
      });
    }
    });

    $("#buscador_proveedores").keyup(function(event){
    let termino = $(this).val();
    let id_compra = $(this).data("compra");
    if(termino.length == 0) {
      $("#tabla_buscador_proveedores tbody").empty();
    }
    else {
      let request_url = getRootUrl() + "/buscador_proveedores/" + termino;
      $.get(request_url, function(data, status){
        if(data.length > 0){
          $("#tabla_buscador_proveedores tbody").empty();
          for(x in data){
            let nombre = data[x].nombre_proveedor;
            let id_proveedor = data[x].id;
            let rowContent = `
               <tr>
                 <td>${nombre}</td>
                 <td>
                     <button 
                       class = "btn btn-primary"
                       onclick="seleccionarProveedor(${id_proveedor}, ${id_compra})"
                       >
                         Agregar
                     </button>
                 </td>
               </tr>
            `;
            $("#tabla_buscador_proveedores tbody").append(rowContent);
          }
        }
      });
    }
    });
    
    
});

window.seleccionarProducto = function (id_producto, id_modelo, tipo_modelo){
  switch(tipo_modelo){
    case 'sales':
      agregarItemVenta(id_producto, id_modelo);
      break;
  case 'purchases':
      agregarItemCompra(id_producto, id_modelo);
      break;
  }
}

window.seleccionarCliente = function (id_cliente, id_venta){
  let request_url = getRootUrl() + "/add_cliente_venta/";
  let info = { cliente_id: id_cliente, id: id_venta };
  $.ajax({
    url: request_url,
    type: 'POST',
    data: JSON.stringify(info),
    contentType: 'application/json; charset=utf-8',
    success: function(result){
      if(result != null) {
        $("#buscador_cliente").modal("hide");
        $('body').removeClass('modal-open');
        $('.modal-backdrop').remove();
        let nombre_cliente = result.nombre_cliente;
        $("#cliente_venta").html("Cliente: " + nombre_cliente)
      }
    }
  });
}

window.seleccionarProveedor = function (id_proveedor, id_compra){
  let request_url = getRootUrl() + "/add_proveedor_compra/";
  let info = { proveedor_id: id_proveedor, id: id_compra };
  $.ajax({
    url: request_url,
    type: 'POST',
    data: JSON.stringify(info),
    contentType: 'application/json; charset=utf-8',
    success: function(result){
      if(result != null) {
        $("#buscador_proveedor").modal("hide");
        $('body').removeClass('modal-open');
        $('.modal-backdrop').remove();
        let nombre_proveedor = result.nombre_proveedor;
        $("#proveedor-compra").html("Proveedor: " + nombre_proveedor)
      }
    }
  });
}



function agregarItemVenta(id_producto, id_venta){
  let cantidad_inicial = $('#cantidad_producto').val();
  let request_url = getRootUrl() + "/add_item_venta/";
    info = { producto_id: id_producto, id: id_venta, cantidad: cantidad_inicial }
  $.ajax({
    url: request_url,
    type: 'POST',
    data: JSON.stringify(info),
    contentType: "application/json; charset=utf-8",
    success: function(result){
      if( result != null ) {
          $("#buscador_producto").modal('hide');
          $('body').removeClass('modal-open');
          $('.modal-backdrop').remove();
	  // estos toman el valor enviado por el controlado y lo colocan en la pantalla
          let cantidad = result.cantidad;
          let precio_producto = result.precio_producto;
          let importe_item = result.importe_item;
          let importe_venta = result.importe_venta;
	  let importe_venta1 = result.importe_venta * 0.16;
	  let importe_venta2 = result.importe_venta * 1.16;
          let nombre_producto = result.nombre_producto;
          let newRowContent = `<tr>
                                 <td>${nombre_producto}</td>
                                 <td>$ ${precio_producto}</td>
                                 <td>${cantidad}</td>
                                 <td>$ ${importe_item}</td>`;
          
          $("#tabla_ventas tbody").append(newRowContent);
          $("#importe_venta_lbl").text("Subtotal de venta: $" + importe_venta);
	  $("#importe_venta_lbl2").text("16% del IVA: $" + importe_venta1);
	  $("#importe_venta_lbl3").text("Total de venta: $" + importe_venta2);
	  location.reload();
      }
    }
  });
}

function agregarItemCompra(id_producto, id_compra){
    let cantidad_inicial = $('#cantidad_producto').val();
    let precio_inicial = $('#precio_detalle_compra').val();
  let request_url = getRootUrl() + "/add_item_compra/";
    info = { producto_id: id_producto, id: id_compra, cantidad: cantidad_inicial, precio_detalle_compra: precio_inicial }
  $.ajax({
    url: request_url,
    type: 'POST',
    data: JSON.stringify(info),
    contentType: "application/json; charset=utf-8",
    success: function(result){
      if( result != null ) {
          $("#buscador_productocompra").modal('hide');
          $('body').removeClass('modal-open');
          $('.modal-backdrop').remove();
	  let id_producto = result.producto_id;
          let cantidad = result.cantidad;
	  let precio_detalle_compra = result.precio_detalle_compra
	  let producto = result.nombre_producto;
	  let importe_item = result.importe_item;
          let importe_compra = result.importe_compra;
	  let importe_compra1 = result.importe_compra * 0.16;
	  let importe_compra2 = result.importe_compra * 1.16;
	  let registro_compra = `<tr>
                                 <td>${producto}</td>
                                 <td>${cantidad}</td>
                                 <td>$${precio_detalle_compra}</td>
                                 <td>$ ${importe_item}</td>
                              </tr>`;
          
          $("#tabla_compras tbody").append(registro_compra);
	  $("#importe_compra_lbl").text("Subtotal de compra: $" + importe_compra);
	  $("#importe_compra_lbl2").text("16% del IVA: $" + importe_compra1);
	  $("#importe_compra_lbl3").text("Total de compra: $" + importe_compra2);
	  location.reload();
      }
    }
  });
}

    
function getRootUrl() {
    return window.location.origin;
}
			  
