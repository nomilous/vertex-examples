
routes = 

    module: 

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


        'missing': (opts, callback) -> 

            callback null, 

                body: ''
                statusCode: 404


        maybe: 

            client: 

                js: (opts, callback) -> 

                    callback null, 

                        'content-type': 'text/javascript'  # dashes are so annoying
                        body: 

                            clear: -> document.innerHtml = ''




#
# enable routes
#

routes.module.function.$api = {} # optional: 'per function config'
routes.module.missing.$api = {}
routes.module.maybe.client.js.$api = cache: true   # ,  expire: ...


require('vertex')
    
    secret: 'π'
    listen: 
        port: 3001

    
    api: 

        listen: port: 3000
        allowRoot: true # false
        root: routes


    log: 

        level: 'debug'


