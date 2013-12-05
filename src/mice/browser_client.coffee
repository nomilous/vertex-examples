

#
# connect to the vertex from a browser client
# ===========================================
#


module.exports = (port, secret, name) ->

    #
    # * /build.js script loaded first in html (see routes.view in basic_hub)
    # 


    debug = require('debug') 'vertex-example'
    debug 'name %s', name

    client = require('vertex-client').create

        context: 

            name: name

        secret: 'secret'

        connect: 

            uri: "ws://localhost:#{port}"
            # interval: 2000


        


    client.connect()


    #
    # pending proper interface to the socket
    # ======================================
    #
    # broadcast mouse position to peers
    #

    document.onmousemove = (e) -> 

        client.socket.send JSON.stringify

            event: 'broadcast'
            data: 

                mouse:

                    x: e.x
                    y: e.y



    #
    # chart mouse position from other browser at http://localhost:3000/view
    # 

    chart = new SmoothieChart

        grid: 

            strokeStyle:'rgb(125, 0, 0)'
            fillStyle:'rgb(60, 0, 0)'
            lineWidth: 1
            millisPerLine: 250
            verticalSections: 6

        labels: 

            fillStyle:'rgb(60, 0, 0)'

    chart.streamTo document.getElementById "mycanvas"

    chart.addTimeSeries xLine = new TimeSeries, 

        strokeStyle:'rgb(0, 255, 0)'
        fillStyle:'rgba(0, 255, 0, 0.4)'
        lineWidth: 3

    chart.addTimeSeries yLine = new TimeSeries, 

        strokeStyle:'rgb(255, 0, 255)'
        fillStyle:'rgba(255, 0, 255, 0.3)'
        lineWidth: 3


    client.socket.on 'message', (payload) -> 

        try 
            {x, y} = JSON.parse( payload ).mouse
            time   = new Date().getTime()
            xLine.append time, parseInt x
            yLine.append time, parseInt y

