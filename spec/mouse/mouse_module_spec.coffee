
{ipso, tag, mock, define} = require 'ipso'

describe 'mouse', ipso (should) -> 

    before ipso (MouseModule) -> 

        tag

            instance: MouseModule.create 3000, 'secret'
            VertexClient: require 'vertex-client'


        mock('vertexClient').with
            connect: -> 
            socket: mock('socket').with
                send: -> 
                on: ->

        mock('body').with append: -> container

        container = mock('container').with 
            css: -> return container # chainable
            on: -> container

        peer = mock('peer').with
            addClass: -> peer
            css: -> peer 

        #
        # define / stub 'dom' module to return appropriate el mock 
        #

        define dom: (selector) ->
            switch selector 
                when 'body' then return get 'body'
            


    beforeEach ipso (VertexClient, vertexClient) -> 

        VertexClient.create = -> vertexClient



    it 'generates a self calling controller', 

        ipso (instance) -> 

            instance.controller

                query: name: 'NAME'
                (err, result) ->

                    result.headers['Content-Type'].should.equal 'text/javascript'
                    result.body.should.match /\(function \(port, secret, name\)/
                    result.body.should.match /\).call\(self, '3000', 'secret', 'NAME'\);/



    it 'generates a view that calls the controller with name query', 

        ipso (instance) -> 

            instance.view

                query: name: 'NAME'
                (err, result) ->

                    result.headers['Content-Type'].should.equal 'text/html'
                    result.body.should.match /<script src="\.\/controller\?name=NAME"/




    it 'creates vertex client and connects to the vertex hub with configured port, secret and name',

        ipso (MouseModule, VertexClient, vertexClient) -> 

            VertexClient.does create: (config) ->

                config.should.eql 

                    #
                    # bug: not showing the json differer on fail
                    #

                    uuid: 'name'
                    context: name: 'name'
                    secret: 'secret'
                    connect: uri: "ws://localhost:9999"


                return vertexClient.does connect: ->


            MouseModule.browserClient 9999, 'secret', 'name'



    it 'appends container div into body that spans 100% and listens for mousemove', 

        ipso (MouseModule, body, container) -> 

            body.does 

                append: (html) -> 

                    html.should.equal '<div></div>'
                    return container


            container.does

                #
                # test with spies (to allow original mock to sill do the chaining)
                #

                _css: (style) -> 

                    style.should.eql

                        width: '100%'
                        height: '100%'

                _on: (pub, sub) ->

                    pub.should.equal 'mousemove'


            MouseModule.browserClient 'PORT', 'SECRET', 'NAME'



    it 'inserts all listed peer elements into container on event "peer" with action "list"'


    it 'appends peer element into container on event "peer" with action "join"', 

        ipso (MouseModule, socket, container, peer) -> 

            socket.does on: (pub, sub) ->

                if pub is 'message' then sub JSON.stringify 

                    event: 'peer'
                    action: 'join'
                    uuid: 'UUID'


            container.does

                find: (selector) ->

                    #
                    # attempts to locate peer element before appending and mocks none
                    #

                    selector.should.equal '.peer.UUID'
                    return els: []

                append: (html) ->

                    html.should.equal '<div>UUID</div>'

                    return peer.does

                        _css: (style) -> 

                            style.should.eql

                                visibility: 'visible'
                                position: 'absolute'


            MouseModule.browserClient 'PORT', 'SECRET', 'NAME'


