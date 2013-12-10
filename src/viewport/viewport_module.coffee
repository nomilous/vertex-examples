module.exports.create = (port, secret) -> 

    viewport = 

        controller: (opts, callback) -> 

            callback null, 

                headers: 'Content-Type': 'text/javascript'
                body: "(#{
                    module.exports.browserClient.toString()
                }).call(self, '#{port}', '#{secret}', '#{opts.query.name}');"


        view: (opts, callback) ->

            name = opts.query.name || 'Untitled'

            callback null, 

                headers: 'Content-Type': 'text/html'
                body: """
                    <body>
                    <script src="/build.js"></script>
                    <script src="./controller?name=#{name}"></script>
                    </body>
                """


    viewport.controller.$www = {}
    viewport.view.$www = {}

    return viewport


module.exports.browserClient = (port, secret, name) ->

    client = require('vertex-client').create

        uuid: name # temporary
        context: 
            name: name
        secret: secret
        connect: 
            uri: "ws://localhost:#{port}"
            # interval: 2000


    client.connect()

    dom   = require 'dom'
    THREE = require 'three'

    container = dom('body').append '<div></div>'


    #
    # http://www.aerotwist.com/tutorials/getting-started-with-three-js/
    # 

    width    = 400
    height   = 300
    fov      = 45
    aspect   = width / height
    near     = 0.1
    far      = 1000
    renderer = new THREE.WebGLRenderer
    camera   = new THREE.PerspectiveCamera fov, aspect, near, far

    console.log camera.moo()

    scene    = new THREE.Scene

    scene.add camera
    camera.position.z = 300
    renderer.setSize width, height
    renderer.setClearColor 0x222222, 1
    

    container.append renderer.domElement


    radius          = 50
    segments        = 16
    rings           = 16
    sphereGeometry  = new THREE.SphereGeometry radius, segments, rings
    sphereMaterial  = new THREE.MeshLambertMaterial color: 0xCC0D0E
    sphere          = new THREE.Mesh sphereGeometry, sphereMaterial
    scene.add sphere 


    pointLight = new THREE.PointLight 0xFFFFFF
    pointLight.position.x = 10
    pointLight.position.y = 50
    pointLight.position.z = 130
    scene.add pointLight 


    renderer.render scene, camera

