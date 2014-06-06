
// jQuery(function($) {
// jQuery(document).ready(function($)
$(function()
{
    console.log("test");
      // var color;
      // "ul.dropdown-menu > li > a"
      $("td.dropdown > ul.dropdown-menu > li > a").click(function() {
        // $(".nook").click(function() {

        var color = $(this).css("background-color");
        // console.log (color);
        console.log("test2");

        // var index = $(this).parent().parent().parent().parent().parent().index();
        var $e = $(this).parent().parent().parent();
        $(this).parent().parent().dropdown('toggle');
        // $e.dropdown('toggle');
        // console.log($e);
        // var index = $(this).index();
        // $( "td.dropdown:eq( 2 )" ).css( "color", "red" );
        // $( "td.dropdown:eq("+index+")").css( "background-color", color );
        $e.css( "background-color", color );
        // console.log(index);

        return false;
      });
});

