function validateNum() {
    // return
    // if passes
    console.log("enter validateNum")
    var num  = $(".string.tel").val()


    //stripped_number.match(/^\d{10}/)[0] === stripped_number

    var stripped_number = num.replace(/[-\s()\D]/g,"");
    if(stripped_number.length === 10){
    } else{
      alert("Follow this format for a phone number \n 'xxxxxxxxxx'")
      event.preventDefault()
    }
}

function bindValidateNum() {
  $('form#new_invite').on('submit', validateNum);
}

// $(document).on('turbolinks:load', bindValidateNum);
$(document).ready(bindValidateNum);



