```

sudo npm install -g coffee-script node-dev git-seed bunyan


git seed clone # once 
sudo npm isntall -g component
component install # once


#
# while vertex-client still under development
# force component update from develop branch
# and pull the latest/unreleased node(sub)_module
#

component install nomilous/vertex-client@develop -f && component build
git seed pull


#
# start vertex hub 
#

node-dev src/basic/basic_hub.coffee | bunyan


#
# clients browser / node
#

[browser client](http://localhost:3000/view)
node-dev src/basic/basic_client.coffee



```
