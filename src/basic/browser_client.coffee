module.exports = (port, secret) ->

    #
    # assumes eio client loaded first
    # todo: ? wss://
    # 

    socket = eio "ws://localhost:#{ port }"

    #
    # todo: component? / requirejs?
    #

    # socket = require('engine.io') "ws://localhost:#{ port }"



    socket.onopen = -> 

        socket.send "1#{JSON.stringify

            event: 'handshake'
            data: 
                title:   'Browser Client'
                uuid:    'UUID'
                context: {}
                secret:  secret

        }"

    socket.onmessage = (msg) -> 

        obj = JSON.parse msg.data.substr 1 
        console.log obj

    socket.onclose = -> 

        console.log 'close'
    

