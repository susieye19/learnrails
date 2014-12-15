$(".registrations").ready ->
  $.externalScript("https://js.stripe.com/v2/").done (script, textStatus) ->
    Stripe.setPublishableKey($('meta[name="stripe-key"]').attr('content'));
    subscription.setupForm()

subscription =
  setupForm: ->
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

    # Submission of change plan form for existing subscribers
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
        
    # Submission of update card form for existing subscribers
    $('#card_form').submit ->
      $('input[type=submit]').attr('disabled', true)
      $('#card_error').hide()
      Stripe.card.createToken($('#card_form'), subscription.handleCardResponse)
      false

    # Click unsubscribe button for existing subscribers
    $('#unsubscribe_form').submit ->
      $('input[type=submit]').attr('disabled', true)


  handleStripeResponse: (status, response) ->
    if status == 200
      $('#user_stripe_card_token').val(response.id)
      $('#payment_form')[0].submit()
    else
      $('#stripe_error').text(response.error.message).show()
      $('input[type=submit]').attr('disabled', false)
  
  handleCardResponse: (status, response) ->
    if status == 200
      $('#user_stripe_card_token').val(response.id)
      $('#card_form')[0].submit()
    else
      $('#card_error').text(response.error.message).show()
      $('input[type=submit]').attr('disabled', false)    