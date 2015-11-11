//alert('ajax works!');
$(document).ready(function() {
    $('#dbrefresh_environment').on('change', function() {
        var p = $('.controls :selected').html();
        var str = "<input class=\"btn\" data-class=\"btn-primary\" data-confirm=\"Are you sure you want to run a DB refresh for environment:    "
        var str2 = "data-id=\"button\" name=\"commit\" type=\"submit\" value=\"Run DB Refresh\" /></form><p>"
        var str3 = str  + p  + "?\""  + str2
        $('.myform').html(str3);
    });
    $('.soarefresh').on('change', function() {
        var p = $('.controls :selected').html();
        var str = "<input class=\"btn\" data-class=\"btn-primary\" data-confirm=\"Are you sure you want to run a SOA refresh for environment:    "
        var str2 = "data-id=\"button\" name=\"commit\" type=\"submit\" value=\"Run SOA Refresh\" /></form><p>"
        var str3 = str  + p  + "?\""  + str2
        $('.myform').html(str3);
    });
});

$(document).ready(function() {
    $('#user').hover(function() {
        $('#popup').show();
    }, function() {
        $('#popup').hide();
    });
});