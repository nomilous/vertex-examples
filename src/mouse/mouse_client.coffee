#
# node-side client 
#


debug  = require('debug') 'vertex-examples:basic_client'
Client = require 'vertex-client'

uuid   = process.env.NAME || 'ClientZero'  # 'e2abc7fe-f602-4112-9a14-010018253cbd'

client = Client.create
    
    title: 'Vertex Client'

    #
    # ### uuid
    # 
    # * used for continuity of context on the remote hub
    # * will default new uuid if not specified (no context continuity)
    # * need not be a fullblown uuid
    #

    uuid: uuid

    context: 
        name: uuid

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

    # message = JSON.parse payload

    # if message.event is 'peer' then console.log client.peers
    # else

    #     console.log payload


x = 0
y = 0
position = x: 300, y: 200
radius = x: 200, y: 100


infinity = -> 

    #
    # fake the mousemove traces infinity symbol
    #

    client.socket.send JSON.stringify

        event: 'broadcast'
        data:

            event: 'mousemove'
            uuid: uuid

            x: position.x + (radius.x * Math.cos x++ / 20)
            y: position.y + (radius.y * Math.sin y++ / 10)


setInterval infinity, 10
