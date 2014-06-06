
// jQuery(function($) {
// jQuery(document).ready(function($)
$(function()
{
    // console.log("test");
      // var color;
      // "ul.dropdown-menu > li > a"
      var test;
      $("td.dropdown > ul.dropdown-menu > li > p").click(function() {
        // $(".nook").click(function() {
      // $("td.dropdown.dropdown-toggle > ul.dropdown-menu > li > a").click(function() {

        var color = $(this).css("background-color");
        console.log (color);
        // console.log("test2");

        // var index = $(this).parent().parent().parent().parent().parent().index();
        var $e = $(this).parent().parent().parent();
        // $(this).parent().parent().dropdown('toggle');

        $e.css( "background-color", color );

        test = color;

        // return color;

        // console.log(index);

        // return false;
      });


});

