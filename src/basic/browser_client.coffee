

#
# connect to the vertex from a browser client
# ===========================================
#


module.exports = (port, secret) ->

    #
    # * /build script loaded first in html (see routes.view in basic_hub)
    # 

    client = require('vertex-client').create

        secret: 'secret'

        connect: 

            uri: "ws://localhost:#{port}"
            # interval: 2000


    client.connect()


    #
    # pending proper interface to the socket
    # ======================================
    #
    # broadcast mouse position to peers
    #

    document.onmousemove = (e) -> 

        client.socket.send JSON.stringify

            event: 'broadcast'
            data: 

                mouse:

                    x: e.x
                    y: e.y



    client.socket.on 'message', (payload) -> 

        console.log payload
