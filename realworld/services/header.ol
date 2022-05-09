from GatewayInterfaceModule import GatewayInterface
from runtime import Runtime
from PageInterfaceModule import PageInterface
from file import File
from json_utils import JsonUtils
from console import Console
from ..app.api import Api 


type Params {
    location:string
    root:string
    contentDir:string
    servicesDir:string
    defaultPage:string
    routes:string
    url:string
    token?:undefined
    currentUrl:string
    
}

service Main( params:Params ) {
    embed Runtime as Runtime
    embed File as File
    embed JsonUtils as JsonUtils
    embed Console as Console
    embed Api as Api 


    define operations {
        document += "
document += "
document += "
if (currentUrl=="") { 
document += "
} 
document += "
isAuth@Api(token)(isAuth)
document += "
if (isAuth==false) { 
document += "
if (currentUrl=="login") { 
document += "
} 
document += "
if (currentUrl=="register") { 
document += "
} 
document += "
} else { 
document += "
if (currentUrl=="editor") { 
document += "
} 
document += "
if (currentUrl=="settings") { 
document += "
} 
document += "
me@Api(token)(user)
document += "
if (currentUrl=="settings") { 
document += "
} 
document += "
document += user.image
document += "\">
document += user.username
document += "
} 
document += "

    }

    execution { single }

    inputPort Local {
        location: "local"
        interfaces: PageInterface
    }

    outputPort Gateway {
        location: "socket://localhost:8000"
        protocol: http { format = "json" }
        interfaces: GatewayInterface
    }

    outputPort Page {
        interfaces: PageInterface
    }

    init {
        getLocalLocation@Runtime()(Page.location)
        document = ""
    }

    main {
        getDocument(request)(response) {

            token = params.token 
currentUrl = params.currentUrl 

            

            operations
            response = document
        }
    }
}