$(document).ready(function() {

  // Validation loop
  function ValidateForm(type) {
    this.getError = function() {
      error = this[type]();
      if (error) {
        var result = error;
        }
      return result;
    };
  }

  // Validations for signup form
  ValidateForm.prototype = {
    email: function(){
      var email = $('form input[type=email]').val();
      var checkEmail = /.+\@.+\..+/;
      if (!checkEmail.test(email)) {
        return "Must be a valid email address!";
      }
    },

    passwordLength: function(){
      var password = $('form input[type=password]').val();
      if (password.length < 8) {
        return "Password must be at least 8 characters!";
      }
    }
  };

  // Show errors for validations
  var displayError = function(error) {
    var display = " <span class='error small'>" + error + "</span>"
    $('.clear').after(display);
    $('.error').fadeOut(4000);
    };

  // Show login and signup forms
  $('a.nav').on('click', function(event) {
    var goTo = $(this).attr('href');
    event.preventDefault();
      $.get(goTo, function(response) {
        $('.form').remove();
        $('#emptybox').append(response);

        // Validate form email
        $('input[type=email]').on('blur', function() {
            var validate = new ValidateForm("email");
            var error = validate.getError();
            if (error.length > 0) { displayError(error); }
        });

        // Validate form password
        $('input[type=password]').on('blur', function() {
            var validate = new ValidateForm("passwordLength");
            var error = validate.getError();
            if (error.length > 0) { displayError(error); }
        });
        
      });
  });

  // Remove login and signup forms
  $('a.clear').on('click', function(event) {
    event.preventDefault();
    $(this).parent().remove();
  });
});