
#
# start vertex hub 
#

node-dev src/mice/mice_hub.coffee | bunyan


#
# clients browser / node
#

[http://localhost:3000/view?name=ClientName](http://localhost:3000/view?name=ClientName)

node-dev src/basic/mouse_client.coffee


