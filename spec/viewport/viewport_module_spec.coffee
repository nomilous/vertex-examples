{ipso, mock, tag, define} = require 'ipso'

describe 'viewport', ->

    before ipso (ViewportModule) -> 

        tag Uplink: require 'vertex-client'

        define

            $dom: (select) -> append: -> append: ->

            three: -> 

                #
                # TODO: sensible way to mock classes
                #

                WebGLRenderer: class
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




    it 'needs ipso.define() to support object export', 

        ipso (ViewportModule) -> 

            #
            # run browserClient
            #

            ViewportModule.browserClient 'PORT', 'SECRET', 'NAME'

