$(document).on('turbolinks:load', function(){

  $('body').on('click', '.btn-danger', function(){

    event.preventDefault();
    console.log("delete that bitch");
    $.ajax({

    })

  });

});
