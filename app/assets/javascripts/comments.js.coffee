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
      $(xhr.responseText).hide().insertAfter($(this)).show('slow')

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
      
  # Upvote a comment
  $(".upvote")
    .on 'ajax:success', (e, data, status, xhr) ->
      $(this).html(data.count)
      
  # Undo an upvote
  # TO DO

  # Delete a comment
  $(".close").click ->
    $(this).parent().parent().fadeTo('fast', 0.5)
    $(this).parent().parent().hide('fast')