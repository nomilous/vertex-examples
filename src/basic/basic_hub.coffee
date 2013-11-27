port   = 3001
secret = 'secret'

routes = 

    # 
    # login:    new require('some_node_module').Login config: ''
    # register: new require('some_node_module').Register config: ''
    # 
    # accounts:  new require('some_node_module_with_both_the_above').Accounts config: ''
    #

    module: 

        view: (opts, callback) -> 

            #
            # http://localhost:3000/module/view
            #

            callback null,
                headers: 'Content-Type': 'text/html'   # <-------------- too much work
                body: """

                    <script src="/engine.io.js"></script>
                    <script src="/module/controller"></script>

                """

                # render:
                #     template: ... (filetype informs renderer to use eg. jade)
                #     data: ... (serverside data injection into templates still usefull?)


        controller: (opts, callback) -> 

            callback null,
                headers: 'Content-Type': 'text/javascript'
                body: "(#{

                    #
                    # require('vertex').Client.toString()
                    #                  .BrowserClient.toString()  # avoid logger /? other possible serverside specifics
                    # 

                    require('./browser_client').toString()

                }).call(self, '#{port}', '#{secret}');"

                        #
                        # - quite like this approach
                        # - just missing the capacity to 'require' in the client script
                        # - can build security in via the args to .call as templated 
                        #   accorging to a preceding web ui login
                        # 


        # help: {}

        #
        # curl :3000/module/function?key=value
        # curl :3000/module/function/1/subrecord/xx
        # curl -XPOST -H 'Content-Type: application/json' :3000/module/function --data '{"key":"value"}'
        # curl -XPUT  -H 'Content-Type: application/json' :3000/module/function/1 --data '{"key":"value"}'
        # curl -XDELETE :3000/module/function/1
        # 

        function: (opts, callback) -> 

            console.log opts
            callback null, '1': subrecord: 
                'xx': da: 'ta1'
                'yy': da: 'ta2'


        missing: (opts, callback) -> 

            callback null, 

                body: ''
                statusCode: 404


       

#
# enable routes
#

routes.module.view.$www = cache: true  # , 'content-type': 'text/html', expire: ...
routes.module.controller.$www = cache: true

routes.module.function.$www = roles: ['admin']
routes.module.missing.$www = {}




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


