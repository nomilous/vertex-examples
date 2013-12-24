```

#
# start vertex hub 
#

node-dev src/hub.coffee



#
# browserConsole: require('debug').enable('vertex*')
#                 require('debug').disable('vertex*')  # refresh
# 

http://localhost:3000/mouse/view?name=ClientOne

# second browser window

http://localhost:3000/mouse/view?name=ClientTwo

# and from the console

DEBUG=vertex* NAME=ClientZero node-dev src/mouse/mouse_client.coffee


#
# BUG: second browser tab in same 'window' causes infinate retry loop on reconnect if hub is restarted
#      non visible tab contains the offending socket
#      does not occur if separate window
#      chrome (other browsers unknown)
#


```