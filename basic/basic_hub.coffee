
routes = 

    module: 

        # help: {}

        #
        # curl :3000/module/function?key=value
        # curl :3000/module/function/1/subrecord/xx
        # curl -XPOST -H 'Content-Type: application/json' :3000/module/function --data '{"key":"value"}'
        # curl -XPUT  -H 'Content-Type: application/json' :3000/module/function/1 --data '{"key":"value"}'
        # curl -XDELETE :3000/module/function/
        # 

        function: (opts, callback) -> 

            console.log opts
            callback null, val: 'ue'




#
# enable /module/function route
#

routes.module.function.$api = {} # optional: 'per function config'



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


