#
# node client
#


debug  = require('debug') 'vertex-examples:basic_client'
Client = require 'vertex-client'

client = Client.create
    
    title: 'Vertex Client'

    #
    # ### uuid
    # 
    # * used for continuity of context on the remote hub
    # * will default new uuid if not specified (no context continuity)
    # * need not be a fullblown uuid
    #

    # uuid:  'e2abc7fe-f602-4112-9a14-010018253cbd'
    uuid: process.env.NAME || 'e2abc7fe-f602-4112-9a14-010018253cbd'

    context: 
        name: process.env.NAME || 'NodeClient'

    #
    # ### secret
    # 
    # * client will be denied unless this matches the hubside secret
    #

    secret: 'secret'

    #
    # ### connect
    # 
    # `connect.uri` - to the desired hub
    # 

    connect: 
        uri: 'ws://localhost:3001'



    log: level: 'debug'


client.connect()


client.socket.on 'message', (payload) -> 

    #
    # temporary pending EventEmitter
    #

    message = JSON.parse payload

    if message.event is 'peer' then console.log client.peers
    else

        console.log payload