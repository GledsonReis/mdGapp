// document.addEventListener("turbolinks:load", () => {
//   $("[data-toggle='tooltip']").tooltip()
// });

// document.addEventListener("turbolinks:load", () => {
//   $("[data-toggle='popover']").tooltip()
// });

var ready = function() {
  $(".opensidebar").on("click", function() {
    $("#mySidenav").css("width", "100%");
  });
  
  /* Close/hide the sidenav */
  $(".closebtn").on("click", function() {
    $("#mySidenav").css("width", "0");
  })

  function readURL(input) {
    if (input.files && input.files[0]) {
        var reader = new FileReader();

        reader.onload = function (e) {
            $('#profile-photo').attr('src', e.target.result);
        }

        reader.readAsDataURL(input.files[0]);
    }
  }

  $("#img-input").change(function(){
      readURL(this);
  });
};

$(document).on('turbolinks:load', ready); 