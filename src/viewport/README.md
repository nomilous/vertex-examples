```

#
# start vertex hub 
# 
# (same server instance as mouse example)
#

node-dev src/hub.coffee | bunyan


#
# browser client
#
# browserConsole: require('debug').enable('vertex*')
# 

http://localhost:3000/viewport/view?name=ClientOne

```

