

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


    setTimeout (->

        #
        # pending event emitter / or callback on connect (undecided)
        #

        console.log client.status

    ), 1000

