from GatewayInterfaceModule import GatewayInterface
from runtime import Runtime
from PageInterfaceModule import PageInterface
from file import File
from json_utils import JsonUtils
from console import Console


type Params {
    location:string
    root:string
    contentDir:string
    servicesDir:string
    defaultPage:string
    routes:string
    
}

service Main( params:Params ) {
    embed Runtime as Runtime
    embed File as File
    embed JsonUtils as JsonUtils
    embed Console as Console
    

    define operations {
        document += "<!DOCTYPE html>\n<html>\n<head>\n<meta charset=\"utf-8\">\n<title>Donatello - First application</title>\n<!-- The following stylesheet is the one used in RealWorld. -->\n<link rel=\"stylesheet\" href=\"//demo.productionready.io/main.css\">\n</head>\n<body>\n<nav class=\"navbar navbar-light\">\n<div class=\"container\">\n<a class=\"navbar-brand\" href=\"articles\">conduit</a>\n<ul class=\"nav navbar-nav pull-xs-right\">\n<li class=\"nav-item\">\n<a class=\"nav-link\" href=\"articles\">All articles</a>\n</li>\n</ul>\n</div>\n</nav>"

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

            
            

            operations
            response = document
        }
    }
}