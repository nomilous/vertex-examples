
#
# start vertex hub 
#

node-dev src/mice/mouse_hub.coffee | bunyan


#
# clients browser / node
#
# browserConsole: require('debug').enable('vertex*')
# 

[http://localhost:3000/view?name=ClientOne](http://localhost:3000/view?name=ClientOne)



#
# BUG: second browser tab in same 'window' causes infinate retry loop on reconnect if hub is restarted
#      non visible tab contains the offending socket
#      does not occur if separate window
#      chrome (other browsers unknown)
#


DEBUG=vertex* NAME=ClientZero node-dev src/mice/mouse_client.coffee

