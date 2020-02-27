// document.addEventListener("turbolinks:load", () => {
//   $("[data-toggle='tooltip']").tooltip()
// });

// document.addEventListener("turbolinks:load", () => {
//   $("[data-toggle='popover']").tooltip()
// });

$(document).ready(function(){
  $(".opensidebar").on("click", function() {
    console.log("gg");
    $("#mySidenav").css("width", "100%");
  });
  
  /* Close/hide the sidenav */
  $(".closebtn").on("click", function() {
    $("#mySidenav").css("width", "0");
  });

});