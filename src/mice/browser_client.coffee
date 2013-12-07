

#
# connect to the vertex from a browser client
# ===========================================
#


module.exports = (port, secret, name) ->

    #
    # * /build.js script loaded first in html (see routes.view in basic_hub)
    # 


    debug = require('debug') 'vertex-example'
    debug 'name %s', name

    client = require('vertex-client').create


        uuid: name # temporary

        context: 

            name: name

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

                event: 'mousemove'
                x: e.x
                y: e.y



    client.socket.on 'message', (payload) -> 

        debug payload