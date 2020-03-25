import consumer from "./consumer"

$(function() {
  $('[data-channel-subscribe="room"]').each(function(index, element) {
    let $element = $(element);
    let room_id = $element.data('room-id');
    let messageTemplate = $('#message-template');

    $element.animate({ scrollTop: $element.prop("scrollHeight")}, 1000)        

    consumer.subscriptions.create(
      {
        channel: "RoomChannel",
        room: room_id
      },
      {
        received: function(data) {
          let current_user = $('.user-id').attr("id");
          // console.log(current_user);
          let content = messageTemplate.children().clone(true, true);
          // console.log(typeof data.user_id);
          // console.log(typeof current_user);
          let alignment = (current_user == data.user_id) ? "end" : "start";
          content.addClass("justify-content-"+alignment);
          content.find('[data-role="message-text"]').text(data.content);
          content.find('[data-role="message-date"]').text(data.updated_at);
          $element.append(content);
          $element.animate({ scrollTop: $element.prop("scrollHeight")}, 1000);
          $("#message-field").val("");
          $("#message-field").focus();
        }
      }
    );
  });
});
