module.exports = (port, secret) ->

    #
    # assumes eio client loaded first
    # todo: component? 
    #

    socket = eio "ws://localhost:#{ port }"



    socket.onopen = -> 

        socket.send "1#{JSON.stringify

            event: 'handshake'
            data: 
                title:   'Client'
                uuid:    'UUID'
                context: {}
                secret:  secret

        }"

    socket.onmessage = (msg) -> 

            obj = JSON.parse msg.data.substr 1 
            console.log obj

    socket.onclose = -> 
    

