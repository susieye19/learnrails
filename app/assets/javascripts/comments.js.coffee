jQuery ->
  # Create a comment
  $(".comment-form")
    .on "ajax:beforeSend", (evt, xhr, settings) ->
      $(this).find('textarea')
        .addClass('uneditable-input')
        .attr('disabled', 'disabled');
    .on "ajax:success", (evt, data, status, xhr) ->
      $(this).find('textarea')
        .removeClass('uneditable-input')
        .removeAttr('disabled', 'disabled')
        .val('');
      # if $(this) == $(".comment-form")[0]
        # $(xhr.responseText).hide().insertAfter($(this)).show('slow')
      # else
      $(xhr.responseText).hide().insertAfter($(this)).show('slow')
      # $('<div class="post">\n'+xhr.responseText+'\n</div>').hide().insertAfter($(this)).show('slow')
      # $(".comment-form:not(:first)").hide()

  # Toggle reply to comment form
  $(".reply-link").click ->
    $(this).next().find('textarea').val('');
    $(this).next().show()
    false

  # Create a reply to a comment
  $(".reply-form")
    .on "ajax:beforeSend", (evt, xhr, settings) ->
      $(this).find('textarea')
        .addClass('uneditable-input')
        .attr('disabled', 'disabled');
    .on "ajax:success", (evt, data, status, xhr) ->
      $(this).find('textarea')
        .removeClass('uneditable-input')
        .removeAttr('disabled', 'disabled')
        .val('');
      $(xhr.responseText).hide().insertAfter($(this)).show('slow')
      $(this).hide();
      # $('<div class="post">\n'+xhr.responseText+'\n</div>').hide().insertAfter($(this)).show('slow')
      # $(".comment-form:not(:first)").hide()

  # Delete a comment
  $(".close").click ->
    $(this).parent().parent().fadeTo('fast', 0.5)
    $(this).parent().parent().hide('fast')

  # # Delete a comment
  # $(document)
  #   .on "ajax:beforeSend", ".comment", ->
  #     console.log(this);
  #     $(this).fadeTo('fast', 0.5)
  #   .on "ajax:success", ".comment", ->
  #     $(this).hide('fast')
  #   .on "ajax:error", ".comment", ->
  #     $(this).fadeTo('fast', 1)