<html>
<script src="//ajax.googleapis.com/ajax/libs/jquery/1.12.0/jquery.min.js"></script>
<script type='text/javascript'>
$(document).ready(function(){
    $('.book').wrap('<div class="container"><div class="row"></div></div>');

    var inner = $('<div class="navbar"><div class="navbar-inner navbar-fixed-top"><span class="pull-right" id="iconbar"><a class="brand" href="https://blog.lnx.cx/"><img src="images/icons/blog-icon-box-rev-32.png" border="0" /></a><a class="brand" href="https://github.com/tbielawa/Virtual-Disk-Guide"><img src="images/icons/GitHub-Mark-32px.png" border="0" /></a><a class="brand" href="http://lnx.cx/docs/vdg/output/Virtual-Disk-Operations.pdf"><img src="images/icons/pdficon_large.png" border="0" /></a><a class="brand" href="https://plus.google.com/110658143146105247699?rel=author" target="_top" style="text-decoration:none;" border="0"><img src="//ssl.gstatic.com/images/icons/gplus-16.png" alt="Google+" style="border:0;width:16px;height:16px;"/></a></span></div></div>');
    $('body').append(inner);
    $('#iconbar img').css('width', 16, 'height', 16);
});
</script>
</html>
