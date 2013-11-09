/* Default class modification */
$.extend( $.fn.dataTableExt.oStdClasses, {
	"sSortAsc": "header headerSortDown",
	"sSortDesc": "header headerSortUp",
	"sSortable": "header"
} );

/* API method to get paging information */
$.fn.dataTableExt.oApi.fnPagingInfo = function ( oSettings )
{
	return {
		"iStart":         oSettings._iDisplayStart,
		"iEnd":           oSettings.fnDisplayEnd(),
		"iLength":        oSettings._iDisplayLength,
		"iTotal":         oSettings.fnRecordsTotal(),
		"iFilteredTotal": oSettings.fnRecordsDisplay(),
		"iPage":          Math.ceil( oSettings._iDisplayStart / oSettings._iDisplayLength ),
		"iTotalPages":    Math.ceil( oSettings.fnRecordsDisplay() / oSettings._iDisplayLength )
	};
}

/* Bootstrap style pagination control */
$.extend( $.fn.dataTableExt.oPagination, {
	"bootstrap": {
		"fnInit": function( oSettings, nPaging, fnDraw ) {
			var oLang = oSettings.oLanguage.oPaginate;
			var fnClickHandler = function ( e ) {
				e.preventDefault();
				if ( oSettings.oApi._fnPageChange(oSettings, e.data.action) ) {
					fnDraw( oSettings );
				}
			};

			$(nPaging).append(
				'<ul class="pagination">'+
					'<li class="prev disabled"><a href="#">&larr; '+oLang.sPrevious+'</a></li>'+
					'<li class="next disabled"><a href="#">'+oLang.sNext+' &rarr; </a></li>'+
				'</ul>'
			);
			var els = $('a', nPaging);
			$(els[0]).bind( 'click.DT', { action: "previous" }, fnClickHandler );
			$(els[1]).bind( 'click.DT', { action: "next" }, fnClickHandler );
		},

		"fnUpdate": function ( oSettings, fnDraw ) {
			var iListLength = 5;
			var oPaging = oSettings.oInstance.fnPagingInfo();
			var an = oSettings.aanFeatures.p;
			var i, j, sClass, iStart, iEnd, iHalf=Math.floor(iListLength/2);

			if ( oPaging.iTotalPages < iListLength) {
				iStart = 1;
				iEnd = oPaging.iTotalPages;
			}
			else if ( oPaging.iPage <= iHalf ) {
				iStart = 1;
				iEnd = iListLength;
			} else if ( oPaging.iPage >= (oPaging.iTotalPages-iHalf) ) {
				iStart = oPaging.iTotalPages - iListLength + 1;
				iEnd = oPaging.iTotalPages;
			} else {
				iStart = oPaging.iPage - iHalf + 1;
				iEnd = iStart + iListLength - 1;
			}

			for ( i=0, iLen=an.length ; i<iLen ; i++ ) {
				// Remove the middle elements
				$('li:gt(0)', an[i]).filter(':not(:last)').remove();

				// Add the new list items and their event handlers
				for ( j=iStart ; j<=iEnd ; j++ ) {
					sClass = (j==oPaging.iPage+1) ? 'class="active"' : '';
					$('<li '+sClass+'><a href="#">'+j+'</a></li>')
						.insertBefore( $('li:last', an[i])[0] )
						.bind('click', function (e) {
							e.preventDefault();
							oSettings._iDisplayStart = (parseInt($('a', this).text(),10)-1) * oPaging.iLength;
							fnDraw( oSettings );
						} );
				}

				// Add / remove disabled classes from the static elements
				if ( oPaging.iPage === 0 ) {
					$('li:first', an[i]).addClass('disabled');
				} else {
					$('li:first', an[i]).removeClass('disabled');
				}

				if ( oPaging.iPage === oPaging.iTotalPages-1 || oPaging.iTotalPages === 0 ) {
					$('li:last', an[i]).addClass('disabled');
				} else {
					$('li:last', an[i]).removeClass('disabled');
				}
			}
		}
	}
} );

/* Table initialisation */
$(document).ready(function() {
  $.get('senado.csv', function (csv) {
    var csvArray = $.csv.toArrays(csv),
        headers = _formatAsDataTableHeaders(csvArray.shift());

    headers = _hideUnwantedHeaders(headers);

    csvArray.pop(); // There's always an empty row, dunno why

    $('.datagrid').html( '<table cellpadding="0" cellspacing="0" border="0" class="table"></table>');
    $('.datagrid table').dataTable( {
        "aaData": csvArray,
        "aoColumns": headers,
        "oLanguage": {
            "sUrl": "js/datatables.Portuguese.txt"
        },
        "sDom": "<'row'<'span8'><'span8'f>r>t<'row'<'span8'i><'span8'p>>",
        "sPaginationType": "bootstrap",
        "aoColumnDefs": [
          { "sClass": "currency", "aTargets": [12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27] }
        ],
        "fnDrawCallback": function() {
          $('td.currency').each(function() {
            var element = $(this),
                value = element.html();

            element.html(_formatCurrency(value));
          });
        }
    } );
  });

  function _formatAsDataTableHeaders(values) {
    var result = [];

    for (var i in values) {
        result.push({ "sTitle": values[i] });
    }

    return result;
  }

  function _hideUnwantedHeaders(headers) {
    var hideHeaders = [0,  // Código
                       2,  // Referência
                       4,  // Situação
                       7,  // Ref. do Cargo
                       9,  // Ref. da Folha
                       11, // Tipo da Folha
                       13, // Vantagens Pessoais
                       14, // Função Comissionada
                       15, // Gratificação Natalina
                       16, // Horas Extras
                       17, // Outras Remunerações Eventuais
                       18, // Abono de Permanência
                       19, // Reversão ao Teto Constitucional
                       20, // Imposto de Renda
                       21, // PSSS
                       22, // Faltas
                       24, // Diárias
                       25, // Auxílios
                       26] // Outras Vantagens Indenizatórias
    for (var i in hideHeaders) {
      headers[hideHeaders[i]].bVisible = false;
    }

    return headers;
  }

  function _formatCurrency(num) {
    num = num.toString().replace(/\$|\,/g, '');
    if (isNaN(num))
      num = "0";
    sign = (num == (num = Math.abs(num)));
    num = Math.floor(num * 100 + 0.50000000001);
    cents = num % 100;
    num = Math.floor(num / 100).toString();
    if (cents < 10)
      cents = "0" + cents;
    for (var i = 0; i < Math.floor((num.length - (1 + i)) / 3); i++)
      num = num.substring(0, num.length - (4 * i + 3)) + '.' + num.substring(num.length - (4 * i + 3));
    return ((sign) ? '' : '-') + 'R$ ' + num + ',' + cents;
  }
});
