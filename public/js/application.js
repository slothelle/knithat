$(document).ready(function() {

  // Validation loop
  function ValidateForm() {
    this.result = [];
    this.getErrors = function() {
      var validations = ['email', 'passwordLength'];
      for (var i = 0; i < validations.length; i++) {
        error = this[validations[i]]();
        if (error) {
          this.result.push(error)
          }
        }
      return this.result;
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
  var displayError = function(errors) {
    for (var i = 0; i < errors.length; i++) {
      $('.clear').after(" <span class='error small'>" + errors[i] + "</span>");
      $('.error').fadeOut(4000);
    }
  };

  // Show login and signup forms
  $('a.nav').on('click', function(event) {
    var goTo = $(this).attr('href');
    event.preventDefault();
      $.get(goTo, function(response) {
        $('.form').remove();
        $('#emptybox').append(response);

        // Prevent submission, validate form
        $('input[type=submit]').on('click', function(event) {
          event.preventDefault();
          var validate = new ValidateForm();
          var errors = validate.getErrors();
          if (errors.length > 0) { displayError(errors); }
          if (errors.length === 0) { 
            $('input[type=submit]').unbind('click'); 
          }
        });
        
      });
  });

  // Remove login and signup forms
  $('a.clear').on('click', function(event) {
    event.preventDefault();
    $(this).parent().remove();
  });
});