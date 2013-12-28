

# 
# ./node_modules/.bin/ipso --mocha 
# 
# (touch this file)
#

describe 'Describe Vertex', -> 
    
    context 'An Experiment', -> 

        beforeEach (done) ->

            done()

        it 'serves the test stack for 5 seconds', (done) -> 

            @timeout 5000

            #
            # curl -s :3002/test | json
            # =========================
            # 
            # {
            #     "parent": {
            #         "_afterAll": [], 
            #         "_afterEach": [], 
            #         "_beforeAll": [], 
            #         "_beforeEach": [
            #             null
            #         ], 
            #         "parent": {
            #             "_afterAll": [], 
            #             "_afterEach": [], 
            #             "_beforeAll": [], 
            #             "_beforeEach": [], 
            #             "parent": {
            #                 "_afterAll": [], 
            #                 "_afterEach": [], 
            #                 "_beforeAll": [], 
            #                 "_beforeEach": [], 
            #                 "root": true, 
            #                 "title": ""
            #             }, 
            #             "root": false, 
            #             "title": "Describe Vertex"
            #         }, 
            #         "root": false, 
            #         "title": "An Experiment"
            #     }, 
            #     "title": "serves the test stack for 5 seconds"
            # }
            # 
            
            routes = test: (opts, callback) => 

                console.log opts

                #
                # use JSON's stringify filter
                # to "deep copy" a portion of the test stack (excluding circular refs)
                #

                result = JSON.parse JSON.stringify @test, (key, value) ->

                    if key is '' then return value
                    if key is 'title' then return value
                    if key is 'parent' then return value
                    if key is 'root' then return value
                    if key.match /^_before|^_after/ then return value
                    

                callback null, result

                #
                # stop on first hit 
                #

                done()


            routes.test.$www = {}


            require('vertex')

                www: 
                    listen: port: 3002
                    routes: routes

                log: level: 'fatal'


