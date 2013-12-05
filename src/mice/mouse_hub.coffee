port   = 3001
secret = 'secret'

{readFileSync} = require 'fs'

routes = 


    # 
    # login:    new require('some_node_module').Login config: ''
    # register: new require('some_node_module').Register config: ''
    # 
    # accounts:  new require('some_node_module_with_both_the_above').Accounts config: ''
    #


    #
    # publish the component build file
    # --------------------------------
    # 
    # * assumes `component install` and `component build` ( up-to-date )
    #

    'build.js': (opts, callback) -> 

        #
        # TODO: include component endpoints into vertex hub @ /build/*, 
        #       always present if there is a component.json file
        #

        callback null,
            
            headers: 'Content-Type': 'text/javascript'
            body: readFileSync "#{__dirname}/../../build/build.js"


    'smoothie.js': (opts, callback) -> 

        callback null,
            
            headers: 'Content-Type': 'text/javascript'
            body: readFileSync "#{__dirname}/../../smoothie.js"



    controller: (opts, callback) -> 

        #
        # a makeshift js template (tad sneaky)
        #

        callback null,

            headers: 'Content-Type': 'text/javascript'
            body: "(#{


                require('./browser_client').toString()


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

        console.log OPTS: opts

        name = opts.query.name || 'Untitled'

        callback null,

            headers: 'Content-Type': 'text/html'
            body: """

                <canvas id="mycanvas" width="400" height="100"></canvas>


                <script src="/smoothie.js"></script>
                <script src="/build.js"></script>
                <script src="/controller?name=#{name}"></script>

                                <!-- sneak name into script view url query -->


            """

    # module: 

    #     # help: {}

    #     #
    #     # curl :3000/module/function?key=value
    #     # curl :3000/module/function/1/subrecord/xx
    #     # curl -XPOST -H 'Content-Type: application/json' :3000/module/function --data '{"key":"value"}'
    #     # curl -XPUT  -H 'Content-Type: application/json' :3000/module/function/1 --data '{"key":"value"}'
    #     # curl -XDELETE :3000/module/function/1
    #     # 

    #     function: (opts, callback) -> 

    #         console.log opts
    #         callback null, '1': subrecord: 
    #             'xx': da: 'ta1'
    #             'yy': da: 'ta2'


    #     missing: (opts, callback) -> 

    #         callback null, 

    #             body: ''
    #             statusCode: 404


       

#
# enable routes
#

routes['build.js'].$www = {}
routes['smoothie.js'].$www = {}
routes.controller.$www = {}
routes.view.$www = {}

# routes.module.view.$www = cache: true  # , 'content-type': 'text/html', expire: ...
# routes.module.controller.$www = cache: true

# routes.module.function.$www = roles: ['admin']
# routes.module.missing.$www = {}




require('vertex')
    
    secret: secret
    # secret: 'wrong'
    listen: 
        port: port

    
    www:

        listen: port: 3000
        allowRoot: true # false
        root: routes

    log: 

        level: 'debug'


