
module.exports.create = (port, secret) ->

    mouse = 

        controller: (opts, callback) -> 

            #
            # a makeshift js template (tad sneaky)
            #

            callback null,

                headers: 'Content-Type': 'text/javascript'
                body: "(#{


                    module.exports.browserClient.toString()


                }).call(self, '#{port}', '#{secret}', '#{opts.query.name}');"
                                                                #
                                                                # carry name through from url query
                                                                #

                                #
                                # * quite like this approach
                                # * can build security in via the args to .call as templated 
                                #   accorging to a preceding web ui login
                                #  


        view: (opts, callback) ->

            name = opts.query.name || 'Untitled'

            callback null,

                headers: 'Content-Type': 'text/html'
                body: """

                    <body>
                    
                    <script src="/build.js"></script>
                    <script src="./controller?name=#{name}"></script>
                                    <!-- sneak name into script view url query -->
                    </body>

                """

    mouse.controller.$www = {}
    mouse.view.$www = {}

    return mouse



module.exports.browserClient = (port, secret, name) ->

    #
    # `require` calls made inside function because 
    #  function.toString() is sent to the browser, 
    #  surrounding scope will not be present there
    #

    client = require('vertex-client').create

        uuid: name # temporary
        context: 
            name: name
        secret: secret
        connect: 
            uri: "ws://localhost:#{port}"
            # interval: 2000

    client.connect()

    dom = require 'dom'

    container = dom('body').append('<div></div>')

    .css

        width: '100%'
        height: '100%'


    .on 'mousemove', (e) -> 

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

                        unless peer = container.find( selector ).els[0]

                            return insert uuid

                        
                        dom( peer ).css 

                            visibility: 'visible'


                    when 'depart'

                        dom( selector ).css 

                            visibility: 'hidden'

            when 'mousemove'

                dom( selector ).css

                    top: "#{data.y}px"
                    left: "#{data.x}px"


