{ipso, Mock, tag, define} = require 'ipso'

describe 'viewport', ->

    before ipso (ViewportModule) -> 

        tag Uplink: require 'vertex-client'

        define

            $dom: (select) -> append: -> append: ->

            three: -> 

                WebGLRenderer: Mock('renderer').with

                    setSize: ->                
                    setClearColor: ->
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
                    height.should.equal 'FAIL'

                setClearColor: (colour) -> 

                    colour.should.equal 0x222222


            ViewportModule.browserClient 'PORT', 'SECRET', 'NAME'

