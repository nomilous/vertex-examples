

#
# connect to the vertex from a browser client
# ===========================================
#


module.exports = (port, secret) ->

    #
    # * /build script loaded first in html (see routes.view in basic_hub)
    # 

    client = require('vertex-client').create

        connect: 

            uri: "ws://localhost:#{port}"
            # interval: 2000


    client.connect()

