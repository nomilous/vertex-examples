module.exports = (port, secret) ->

    mouse = 

        controller: (opts, callback) -> 

            #
            # a makeshift js template (tad sneaky)
            #

            callback null,

                headers: 'Content-Type': 'text/javascript'
                body: "(#{


                    require('./browser_client').toString()


                }).call(self, '#{port}', '#{secret}', '#{opts.query.name}');"
                                                                #
                                                                # carry name through from url query
                                                                #

                                #
                                # * quite like this approach
                                # * can build security in via the args to .call as templated 
                                #   accorging to a preceding web ui login
                                #  


        view: (opts, callback) ->

            console.log OPTS: opts

            name = opts.query.name || 'Untitled'

            callback null,

                headers: 'Content-Type': 'text/html'
                body: """

                    <div class='container'></div>


                    <script src="/build.js"></script>
                    <script src="./controller?name=#{name}"></script>

                                    <!-- sneak name into script view url query -->


                """

    mouse.controller.$www = {}
    mouse.view.$www = {}

    return mouse
