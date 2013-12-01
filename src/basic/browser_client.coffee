module.exports = (port, secret) ->

    #
    # /build script loaded first in html
    # 

    client = require 'vertex-client'
    client()

