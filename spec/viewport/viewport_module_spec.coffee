{ipso, Mock, tag, define} = require 'ipso'

describe 'viewport', ->

    before ipso (ViewportModule) -> 

        tag Uplink: require 'vertex-client'

        define

            $dom: (select) -> append: -> append: ->

            three: -> 

                #
                # TODO: sensible way to mock classes
                #

                WebGLRenderer: Mock('renderer').with

                    # setSize: ->       # TODO: understand why these prevents
                                        #       the expectations below from
                    # setClearColor: -> #       from functioning properly.
                    render: ->

                PerspectiveCamera: class
                    position: z: 0
                Scene:  class
                    add: ->
                SphereGeometry: class
                MeshLambertMaterial: class
                Mesh: class
                PointLight: class
                    position: x: 0, y: 0, z: 0
                


    beforeEach ipso (Uplink) -> Uplink.does create: -> connect: ->




    it 'creates a renderer of specified size and background colour', 

        ipso (ViewportModule, renderer) -> 

            renderer.does

                setSize: (width, height) -> 

                    width.should.equal 400
                    height.should.equal 300

                setClearColor: (colour) -> 

                    colour.should.equal 0x222222


            ViewportModule.browserClient 'PORT', 'SECRET', 'NAME'

