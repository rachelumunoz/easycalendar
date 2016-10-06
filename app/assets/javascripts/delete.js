// $(document).on('turbolinks:load', function(){
$(document).ready(function(){

  $('body').on('click', '.btn-danger', function(){

    event.preventDefault();
    console.log("delete that bitch");
    $.ajax({

    })

  });

});