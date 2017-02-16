$(document).on('turbolinks:load', function() {
  if ($('#duration_lesson').length) {
    initCountdown();
    if ((typeof $counter) !== 'undefined') {
      clearInterval($counter);
    }
    $counter = setInterval(countdown, 1000);
  }
  $('#category-filter-form').hide();
  $('#word-content').hide();

  $('.word-pill').on('click', function () {
    $('#category-filter-form').show('fast');
    $('#word-content').show('fast');
  });

  $('.lesson-pill').on('click', function () {
    $('#category-filter-form').hide();
    $('#word-content').hide();
  });

  $('#filter_not_learned_words').on('click', function () {
    $('#word-search-form').submit();
  });

  $('#filter_learned_words').on('click', function () {
    $('#word-search-form').submit();
  });

  $('#filter_find_all').on('click', function () {
    $('#word-search-form').submit();
  });

  $('#select').on('change', function () {
    $('#word-search-form').submit();
  });

  var p;
  $('.progress-bar-warning').each(function () {
    p = $(this).html();
    $(this).css('width', p);
    $(this).append(' complete');

  });

  $('input:radio').change(function () {
    $('#number-select').html($(":radio:checked").length);
  });
  $('body').on('hidden.bs.modal', '.modal', function () {
    $(this).removeData('bs.modal');
  });

  $('#div-list-word').on('click', '.word-item-flip', function () {
    $(this).siblings('.word-item-panel').slideToggle('slow');
  });

  $('#div-show-category').on('click', '.remove-answer-row', function () {
    var count = $(this).parent().siblings('.answer-row:visible').length + 1;
    if(count <= 2) {
      alert('Each word must have at least 2 answers');
    } else {
      $(this).prev('input[type=hidden]').val('1');
      $(this).closest('.answer-row').hide();
    }
  }).on('click', '.check-correct', function () {
    $(this).parent().siblings('.answer-row:visible').
    children('.check-correct').prop('checked', false);
  }).on('click', '.btn-add-answer', function (event) {
    event.preventDefault();
    time = new Date().getTime();
    regexp = new RegExp($(this).data('id'), 'g');
    $(this).before($(this).data('fields').replace(regexp,time));
  });
});

function initCountdown() {
  $duration = parseInt($('#duration_lesson').attr('value'));
  $minutes = Math.floor($duration / 60);
  $seconds = $duration - $minutes * 60;
}

function countdown() {
  $('#lesson-countdown').html($minutes + ' : ' + $seconds);
  $seconds--;
  if ($seconds <= -1) {
    if ($minutes <= 0) {
      clearInterval($counter);
      $('form').submit();
    }
    $seconds = 59;
    $minutes--;
  }
}

$(document).ready('onload',function () {
  $('.progress-bar-warning').append(' complete');
  $('.progress-bar-warning').css('width', p);
});
