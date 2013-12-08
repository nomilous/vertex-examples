
{ipso, tag} = require 'ipso'

describe 'mouse', -> 

    before ipso (should) -> 

        Mouse = require '../../lib/mouse'

        tag

            mouse: Mouse 3000, 'secret'


    it 'generates self calling controller', 

        ipso (mouse, should) -> 

            mouse.controller

                query: name: 'NAME'
                (err, result) ->

                    result.headers['Content-Type'].should.equal 'text/javascript'
                    result.body.should.match /\(function \(port, secret, name\)/
                    result.body.should.match /\).call\(self, '3000', 'secret', 'NAME'\);/


    it 'generates view that calls the controller with name query', 

        ipso (mouse, should) -> 

            mouse.view

                query: name: 'NAME'
                (err, result) ->

                    result.headers['Content-Type'].should.equal 'text/html'
                    result.body.should.match /<script src="\.\/controller\?name=NAME"/


