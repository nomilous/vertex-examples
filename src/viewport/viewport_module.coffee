module.exports.create = (port, secret) -> 

    viewport = 

        controller: (opts, callback) -> 

            callback null, 

                headers: 'Content-Type': 'text/javascript'
                body: "(#{
                    module.exports.browserClient.toString()
                }).call(self, '#{port}', '#{secret}', '#{opts.query.name}');"


        view: (opts, callback) ->

            name = opts.query.name || 'Untitled'

            callback null, 

                headers: 'Content-Type': 'text/html'
                body: """
                    <body>
                    <script src="/build.js"></script>
                    <script src="./controller?name=#{name}"></script>
                    </body>
                """


    viewport.controller.$www = {}
    viewport.view.$www = {}

    return viewport


module.exports.browserClient = (port, secret, name) ->

    client = require('vertex-client').create

        uuid: name # temporary
        context: 
            name: name
        secret: secret
        connect: 
            uri: "ws://localhost:#{port}"
            # interval: 2000


    client.connect()

    alert 'okgood'
