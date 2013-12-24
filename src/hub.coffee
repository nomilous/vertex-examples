port   = 3001
secret = 'secret'

{readFileSync} = require 'fs'

routes = 

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
            body: readFileSync "#{__dirname}/../build/build.js"


    mouse:    require('./mouse/mouse_module').create port, secret
    viewport: require('./viewport/viewport_module').create port, secret


#
# enable routes
#

routes['build.js'].$www = {}



require('vertex').create
    
    secret: 'wrong'
    secret: secret
    listen: 
        port: port

    
    www:

        listen: port: 3000
        allowRoot: true # false
        root: routes
