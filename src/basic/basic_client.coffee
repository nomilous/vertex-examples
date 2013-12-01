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

    uuid:  'e2abc7fe-f602-4112-9a14-010018253cbd'

    #
    # ### secret
    # 
    # * client will be denied unless this matches the hubside secret
    #

    secret: 'π'

    #
    # ### connect
    # 
    # `connect.uri` - to the desired hub
    # 

    connect: 
        uri: 'ws://localhost:3001'



    log: level: 'debug'


client.connect()

