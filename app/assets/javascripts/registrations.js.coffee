$(".registrations").ready ->
  $.externalScript("https://js.stripe.com/v2/").done (script, textStatus) ->
    Stripe.setPublishableKey($('meta[name="stripe-key"]').attr('content'));
    subscription.setupForm()

subscription =
  setupForm: ->
    # $('#verify_coupon').click ->
    #   $('#coupon_success').hide()
    #   $('#coupon_error').hide()
    #   for key, value of $('#verify_coupon').data('coupons')
    #     if $('#user_coupon').val().toUpperCase() == value.code
    #       if value.price == 0
    #         $('#stripe_form').hide()
    #       $('#coupon_success').text(value.message).show()
    #       $('#coupon_error').hide()
    #       break

    #   if $('#coupon_success').is(':hidden')
    #     $('#coupon_error').text("Sorry, the coupon you entered isn't valid").show()
    #     $('#coupon_success').hide()
    #   false

    # Submission of payment form
    $('#payment_form').submit ->
      $('input[type=submit]').attr('disabled', true)
      $('#plan_error').hide()

      # Display error message if no plan was selected (for legacy users only)
      if $('#plan_form').length and ($('input[type=radio]:checked').size() == 0)
        $('#plan_error').text("You'll need to choose a plan first!").show()
        $('input[type=submit]').attr('disabled', false)
        false
      else if $('#stripe_form').is(':hidden')
        true
      else if $('#card_number').length
        Stripe.card.createToken($('#payment_form'), subscription.handleStripeResponse)
        false
      else
        true

    # Submission of change plan form for subscribers
    $('#plan_form').submit ->
      $('input[type=submit]').attr('disabled', true)
      $('#plan_error').hide()

      # Display error message if no plan was selected (for legacy users only)
      if $('#plan_form').length and ($('input[type=radio]:checked').size() == 0)
        $('#plan_error').text("You'll need to choose a plan first!").show()
        $('input[type=submit]').attr('disabled', false)
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