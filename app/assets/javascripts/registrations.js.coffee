$(".registrations.new").ready ->
  $.externalScript("https://js.stripe.com/v2/").done (script, textStatus) ->
    Stripe.setPublishableKey($('meta[name="stripe-key"]').attr('content'));
    subscription.setupForm()

$(".registrations.create").ready ->
  $.externalScript("https://js.stripe.com/v2/").done (script, textStatus) ->
    Stripe.setPublishableKey($('meta[name="stripe-key"]').attr('content'));
    subscription.setupForm()

subscription =
  setupForm: ->
    $('#verify_coupon').click ->
      if $('#user_coupon').val().toUpperCase() == "SWSD"
        $('#coupon_success').text("75% off discount applied!").show()
        $('#coupon_error').hide()
        false
      else if $('#user_coupon').val().toUpperCase() == "BROC"
        $('#coupon_success').text("50% off discount applied!").show()
        $('#coupon_error').hide()
        false
      else if $('#user_coupon').val().toUpperCase() == "BRFFC"
        $('#coupon_success').text("50% off discount applied!").show()
        $('#coupon_error').hide()
        false
      else if $('#user_coupon').val().toUpperCase() == "BRSM"
        $('#coupon_success').text("50% off discount applied!").show()
        $('#coupon_error').hide()
        false
      else if $('#user_coupon').val().toUpperCase() == "EVENTSOC"
        $('#coupon_success').text("50% off discount applied!").show()
        $('#coupon_error').hide()
        false
      else if $('#user_coupon').val().toUpperCase() == "JEFF"
        $('#coupon_success').text("Thanks for your support! Your price is now $24.00!").show()
        $('#coupon_error').hide()
        false
      else if $('#user_coupon').val().toUpperCase() == "UDEMY"
        $('#coupon_success').text("Free! You'll still need to input a valid credit card though").show()
        $('#coupon_error').hide()
        false
      else if $('#user_coupon').val().toUpperCase() == "RHONDA"
        $('#coupon_success').text("Free! You'll still need to input a valid credit card though").show()
        $('#coupon_error').hide()
        false
      else if $('#user_coupon').val().toUpperCase() == "FREEACCESS"
        $('#coupon_success').text("Free! You'll still need to input a valid credit card though").show()
        $('#coupon_error').hide()
        false
      else
        $('#coupon_error').text("Sorry, the coupon you entered isn't valid").show()
        $('#coupon_success').hide()
        false

    $('#payment_form').submit ->
      $('input[type=submit]').attr('disabled', true)
      if $('#card_number').length
        Stripe.card.createToken($('#payment_form'), subscription.handleStripeResponse)
        false
      else
        true

  handleStripeResponse: (status, response) ->
    if status == 200
      $('#user_stripe_card_token').val(response.id)
      $('#payment_form')[0].submit()
    else
      $('#stripe_error').text(response.error.message).show()
      $('input[type=submit]').attr('disabled', false)