
{ipso, tag, mock, define} = require 'ipso'

describe 'mouse', ipso (should) -> 

    before ipso -> 

        Mouse = require '../../lib/mouse'

        tag

            Mouse: Mouse
            mouse: Mouse 3000, 'secret'
            VertexClient: require 'vertex-client'


        container = mock('container').with 

            css: -> return container # chainable
            on: -> return container

        mock('body').with 

            append: -> return container


        define

            #
            # define / stub 'dom' module to return appropriate el mock 
            #

            dom: (selector) ->

                switch selector 

                    when 'body' then get 'body'



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

        ipso (Mouse, VertexClient, vertexClient, body, container) -> 

            VertexClient.does create: (config) -> 

                config.should.eql 

                    uuid: 'NAME'
                    context: name: 'NAME'
                    secret: 'SECRET'
                    connect: uri: "ws://localhost:PORT"


                return vertexClient.does connect: -> 


            Mouse.client 'PORT', 'SECRET', 'NAME'


    it 'appends container div into body that spans 100% and listens for mousemove', 

        ipso (Mouse, body, container) -> 

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

                

            Mouse.client 'PORT', 'SECRET', 'NAME'


