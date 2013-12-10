$(".registrations.new").ready ->
  $.externalScript("https://js.stripe.com/v2/").done (script, textStatus) ->
    Stripe.setPublishableKey($('meta[name="stripe-key"]').attr('content'));
    subscription.setupForm()

subscription =
  setupForm: ->
    $('#payment_form').submit ->
      $('input[type=submit]').attr('disabled', true)
      if $('#card_number').length
        subscription.processCard()
        false
      else
        true

  processCard: ->
    card =
      number: $('#card_number').val()
      cvc: $('#card_code').val()
      expMonth: $('#card_month').val()
      expYear: $('#card_year').val()
    Stripe.createToken(card, subscription.handleStripeResponse)

  handleStripeResponse: (status, response) ->
    if status == 200
      $('#user_stripe_card_token').val(response.id)
      $('#payment_form')[0].submit()
    else
      $('#stripe_error').text(response.error.message).show()
      $('input[type=submit]').attr('disabled', false)


# var stripeResponseHandler = function(status, response) {
#   console.log("stripeResponseHandler");

#   var $form = $('#payment_form');

#   if (response.error) {
#     console.log("Response error");
#     // Show the errors on the form
#     // $('#stripe_error').prop("class", "alert alert-danger");
#     // $('#stripe_error').text(response.error.message);
#     $('input[type=submit]').prop('disabled', false);
#     alert("It did not work");
#   } else {
#     console.log("No response error");
#     // token contains id, last4, and card type
#     var token = response.id;
#     console.log(response.id);
#     // Insert the token into the form so it gets submitted to the server
#     $form.append($('<input type="hidden" name="stripeToken" />').val(token));
#     // and submit
#     $form.get(0).submit();
#   }
# };

# jQuery(function($) {
#   // Set Stripe key
#   Stripe.setPublishableKey($('meta[name="stripe-key"]').attr('content'));
#   console.log('set Stripe public key: ' + $('meta[name="stripe-key"]').attr('content'));

#   // Handle form submission
#   $('#payment_form').submit(function(event) {
#     console.log("Form submitted");

#     var $form = $(this);

#     // Disable the submit button to prevent repeated clicks
#     $form.find('input[type=submit]').prop('disabled', true);

#     Stripe.card.createToken($form, stripeResponseHandler);

#     // Prevent the form from submitting with the default action
#     return false;
#   });
# });




# $('.registrations.new').ready(function() {

#   // Wait until external Stripe script is loaded
#   $.externalScript('https://js.stripe.com/v2/').done(function(script, textStatus) {
#     console.log('Script loading: ' + textStatus );
#     if (typeof Stripe != 'undefined') {
#       console.log('Okay. Stripe file loaded.');
#     }
#     else
#     {
#       console.log('Problem. Stripe file not loaded.');
#     }

#     // Set Stripe publishable key
#     Stripe.setPublishableKey($('meta[name="stripe-key"]').attr('content'));
#     console.log('set Stripe public key: ' + $('meta[name="stripe-key"]').attr('content'));

#     var subscription = {

#       // Define setupForm function
#       setupForm: function() {
#         console.log('function: setupForm')
#         return $('payment_form').submit(function() {
#           console.log('setupForm: form submitted')

#           // Prevent form from being submitted twice
#           $('input[type=submit]').prop('disabled', true);
#           subscription.processCard();
#           return false;
#         });
#       },

#       // Define processCard function
#       processCard: function() {
#         console.log('function: processCard');
#         var card;
#         card = {
#           number: $('#card_number').val(),
#           cvc: $('#card_code').val(),
#           exp_month: $('#card_month').val(),
#           exp_year: $('#card_year').val()
#         };
#         return Stripe.card.createToken(card, subscription.stripeResponseHandler);
#       },

#       // Define stripeResponseHandler function
#       stripeResponseHandler: function(status, response) {
#         console.log('function: handleStripeResponse');
#         if (status === 200) {
#           return alert('Stripe response: ' + response.id);
#         } else {
#           return alert('Stripe response: ' + response.error.message);
#         }
#       }
#     };
#     return subscription.setupForm();
#   });
# });