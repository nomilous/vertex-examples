{ipso, mock, tag, define} = require 'ipso'

describe 'viewport', ->

    before ipso (ViewportModule) -> 

        tag Uplink: require 'vertex-client'

        define

            dom: (select) -> 

            three: -> 

                console.log """

                    #
                    # TODO: define to support object (hash/literal) 
                    #       definition, something like:
                    #
                    #       define 
                    #          three:
                    #             Scene: mock 'scene'
                    #             Camera: mock 'camera'
                    # 
                    # 

                """


    beforeEach ipso (Uplink) -> Uplink.does create: -> connect: ->




    it 'needs ipso.define() to support object export', 

        ipso (ViewportModule) -> 

            #
            # run browserClient
            #

            ViewportModule.browserClient 'PORT', 'SECRET', 'NAME'

