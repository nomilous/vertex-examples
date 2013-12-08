
{ipso, tag, mock, define} = require 'ipso'

describe 'mouse', ipso (should) -> 

    before ipso -> 

        Mouse = require '../../lib/mouse'

        tag

            Mouse: Mouse
            mouse: Mouse 3000, 'secret'
            VertexClient: require 'vertex-client'


        mock 'bodyElement' 

        define

            #
            # define / stub 'dom' module to return appropriate el mock 
            #

            dom: (selector) ->

                switch selector

                    when 'body' then get 'bodyElement'

                                    #
                                    # get() is defined on the scope of the 
                                    # exporter that creates the stub module.
                                    #


        socket = mock('socket').with

            send: -> 
            on: ->


        mock('vertexClient').with 

            socket: socket
            connect: -> 


    it 'generates self calling controller', 

        ipso (mouse) -> 

            mouse.controller

                query: name: 'NAME'
                (err, result) ->

                    result.headers['Content-Type'].should.equal 'text/javascript'
                    result.body.should.match /\(function \(port, secret, name\)/
                    result.body.should.match /\).call\(self, '3000', 'secret', 'NAME'\);/


    it 'generates view that calls the controller with name query', 

        ipso (mouse) -> 

            mouse.view

                query: name: 'NAME'
                (err, result) ->

                    result.headers['Content-Type'].should.equal 'text/html'
                    result.body.should.match /<script src="\.\/controller\?name=NAME"/



    it 'enable testing here ( despite client-side-only components being required [ without running browser { or headless browser',

        ipso (Mouse, VertexClient, vertexClient, bodyElement) -> 

            VertexClient.does create: (config) -> 

                config.should.eql 

                    uuid: 'NAME'
                    context: name: 'NAME'
                    secret: 'SECRET'
                    connect: uri: "ws://localhost:PORT"


                return vertexClient.does connect: -> 


            bodyElement.does append: -> css: -> on: ->


            #
            # problems to solve
            # -----------------
            # 
            # DONE: * Error: Cannot find module 'dom'   (component only)
            # DONE: * it exports a function             (difficult to stub)
            # * it can't return an injectable mock

            Mouse.client 'PORT', 'SECRET', 'NAME'




