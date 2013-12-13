```

#
# start vertex hub 
#

node-dev src/hub.coffee


#
# clients browser / node
#
# browserConsole: require('debug').enable('vertex*')
# 

http://localhost:3000/mouse/view?name=ClientOne


#
# BUG: second browser tab in same 'window' causes infinate retry loop on reconnect if hub is restarted
#      non visible tab contains the offending socket
#      does not occur if separate window
#      chrome (other browsers unknown)
#


DEBUG=vertex* NAME=ClientZero node-dev src/mouse/mouse_client.coffee



NAME=one node-dev src/mouse/mouse_client.coffee &
NAME=two node-dev src/mouse/mouse_client.coffee &
NAME=thr node-dev src/mouse/mouse_client.coffee &
NAME=fou node-dev src/mouse/mouse_client.coffee &

ps aux | grep mouse_client.coffee | awk '{print $2}' | xargs kill


```