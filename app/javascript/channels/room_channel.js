import consumer from "./consumer"

consumer.subscriptions.create("RoomChannel", {
  connected() {
    // Called when the subscription is ready for use on the server
  },

  disconnected() {
    // Called when the subscription has been terminated by the server
  },

  received(data) {
    $('#chat_'+data.chat_id).append('<div class="row m-1 justify-content-start"><div class="rounded-lg bg-primary text-white px-4 py-2"><p class="m-0 text-small font-weight-bolder">' + data.content + '</p></div></div>')
    // Called when there's incoming data on the websocket for this channel
  }
});
