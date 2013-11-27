module.exports = (port, secret) ->

    #
    # assumes eio client loaded first
    # todo: ? wss://
    # 

    socket1 = new eio.Socket "ws://localhost:#{ port }"

    #
    # todo: component? / requirejs?
    #

    # socket = require('engine.io') "ws://localhost:#{ port }"



    socket1.onopen = -> 

        socket1.send "1#{JSON.stringify

            event: 'handshake'
            data: 
                title:   'Browser Client One'
                uuid:    'UUID'
                context: {}
                secret:  secret

        }"

    socket1.onmessage = (msg) -> 

        obj = JSON.parse msg.data.substr 1 
        console.log 'socket 1', obj

    socket1.onclose = -> 

        console.log 'close'
    



    #
    # second browser socket as if to different host
    #


    socket2 = new eio.Socket "ws://alt-host-en1-in-hosts-file:#{ port }"

    socket2.onopen = -> 

        socket2.send "1#{JSON.stringify

            event: 'handshake'
            data: 
                title:   'Browser Client Two'
                uuid:    'UUID'
                context: {}
                secret:  secret

        }"

    socket2.onmessage = (msg) -> 

        obj = JSON.parse msg.data.substr 1 
        console.log 'socket 2', obj

    socket2.onclose = -> 

        console.log 'close'
    

