/**
 * Created with JetBrains RubyMine.
 * User: junv
 * Date: 12/5/12
 * Time: 12:59 PM
 * To change this template use File | Settings | File Templates.
 */
$(document).ready(function(){
    var dispatcher = new WebSocketRails('localhost:3000/websocket');

    dispatcher.on_open = function(data) {
        console.log('Connection has been established: ' + data);
        // You can trigger new server events inside this callback if you wish.
    }

    var comment = {
        title: 'This post was awful',
        body: 'really awful',
        post_id: 9
    }

    dispatcher.trigger('new_message',comment)

    dispatcher.bind('new_message', function(message) {
        console.log(message.title);
    });

});

