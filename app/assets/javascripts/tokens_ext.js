$(document).ready(function() {
    console.log("in proj.js")  ;
    $('#filter_by_name_field').keyup(function() {
        $('table.table-layout tbody tr').show().filter(function() {
            var token = $(this).find('td').first().text().toLowerCase();
            return !~token.indexOf($('#filter_by_name_field').val().toLowerCase());
        }).hide();
    });
    // if desired:
    //$('#filter_by_all_field').keyup(function() {
    //    $('table.table-layout tbody tr').show().filter(function() {
    //        var all_vals = $(this).text().toLowerCase();
    //        return !~all_vals.indexOf($('#filter_by_all_field').val().toLowerCase());
    //    }).hide();
    //});

    //$('.project').hide();
    $(document).ready(function() {
      //$('.project').hide();
    });
    if ((document.getElementById('view_global')) && (document.getElementById('view_global').checked)){
        $('.project').hide();
    }
    else{
        $('.project').show();
    }
    $('.global_view').on('change', function() {
        $('.project').toggle();
    });
    $('.service_view').on('change', function() {
        $('.project').toggle();
    });


    $('#text_box_label901').hide();
    $('#text_box_label900').hide();
    $('#text_box_label901').on('change', function() {
        console.log("here88") ;
        $("#actions").focus;
    });

    $(function(){
        $('a, button').click(function() {
            $(this).toggleClass('active');
        });
    });


    //   $('.spinner').hide();
 //   $(".btnspin").click(function() {
 //       console.log("in spinner")
 //       $('.spinner').show()
 //   });
 //   console.log("in spinner2")


    $('#new').hide();
    $('#new2').hide();
    $('#add_token').hide();
    $('.newuser').show();
    $('.add_tok').show();
    $(document).ready(function() {
        $('.newuser').hover(function() {
            $('#new').show();
        }, function() {
            $('#new').hide();
        });
    });
    $(document).ready(function() {
        $('.newuser2').hover(function() {
            $('#new2').show();
        }, function() {
            $('#new2').hide();
        });
    });
    $(document).ready(function() {
        $('.add_tok').hover(function() {
            $('#add_token').show();
        }, function() {
            $('#add_token').hide();
        });
    });

    //$('.field').on('change', function() {
    $(documents).ready(function() {

        selector =$("#branch_project_name").val();

        var p = $('.field66 :selected').html();

        var str1=	"<a href=\"#\" onclick=\"javascript:window.open(&#x27;https://deploy.newokl.com/php/db_refresh.html"
        var str2= "&amp;domain="
        var str2 = ""
        var str3= "&#x27;,&#x27;popup&#x27;,&#x27;scrollbars=1,width=900,height=600&#x27;);\"><b><font color=DF0101><ul>Go To DB Refresh Status Page"  + "</ul></font></b></a>"
        var str4= "<ul>"  + str1 + selector + str2 + selector + str3 + "</ul>"
        var str4= "<ul>"  + str1 + str3 + "</ul>"
        $('div.linkto-container').html(str4);

        //$('.field676').show();
        //$('.field677').show();
    })
});
