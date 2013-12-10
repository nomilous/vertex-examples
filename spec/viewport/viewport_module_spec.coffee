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

                PerspectiveCamera: Mock('camera').with
                    position: z: 0
                    
                Scene:  class
                    add: ->
                SphereGeometry: class
                MeshLambertMaterial: class
                Mesh: class
                PointLight: class
                    position: x: 0, y: 0, z: 0
                


    before ipso (Uplink) -> Uplink.does create: -> connect: ->



    it 'creates a camera instance with specified fieldOfView, aspectRatio and clipping planes',

        ipso (ViewportModule, camera, should) -> 

            camera.does 

                constructor: (fov, aspect, near, far) -> 

                    @moo = -> 'just checking'

                    fov.should.equal 45
                    aspect.should.equal 400 / 300
                    near.should.equal 0.1
                    far.should.equal 1000



            ViewportModule.browserClient 'PORT', 'SECRET', 'NAME'



    xit 'creates a renderer of specified size and background colour', 

        ipso (ViewportModule, renderer, should) -> 

            renderer.does

                setSize: (width, height) -> 
                    width.should.equal 400
                    height.should.equal 300

                setClearColor: (colour) -> 
                    colour.should.equal 0x222222


            ViewportModule.browserClient 'PORT', 'SECRET', 'NAME'

