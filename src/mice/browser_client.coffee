

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



    dom = require 'dom'
    container = dom '.container'


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


    insert = (uuid) -> 

        container.append("<div>#{uuid}</div>")
        .addClass('peer')
        .addClass(uuid)
        .css 
            visibility: 'visible'
            position: 'absolute'


    client.socket.on 'message', (payload) -> 

        data     = JSON.parse payload
        event    = data.event
        uuid     = data.uuid
        selector = ".peer.#{uuid}"

        switch event

            when 'peer'

                action = data.action
                list   = data.list

                switch action

                    when 'list'

                        insert uuid for uuid of list

                    when 'join', 'resume'

                        peer = insert uuid unless peer = dom( selector )
                        dom( peer ).css

                            visibility: 'visible'
                            position: 'absolute'


                    when 'depart'

                        dom( selector ).css

                            visibility: 'hidden'
                            position: 'absolute'


