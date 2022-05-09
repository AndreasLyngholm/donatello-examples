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
        document += "\n"
document += "\n"
document += "\n<!DOCTYPE html>\n<html>\n<head>\n    <meta charset=\"utf-8\">\n    <title>Conduit</title>\n    <!-- Import Ionicon icons & Google Fonts our Bootstrap theme relies on -->\n    <link href=\"//code.ionicframework.com/ionicons/2.0.1/css/ionicons.min.css\" rel=\"stylesheet\" type=\"text/css\">\n    <link href=\"//fonts.googleapis.com/css?family=Titillium+Web:700|Source+Serif+Pro:400,700|Merriweather+Sans:400,700|Source+Sans+Pro:400,300,600,700,300italic,400italic,600italic,700italic\"\n          rel=\"stylesheet\" type=\"text/css\">\n    <!-- Import the custom Bootstrap 4 theme from our hosted CDN -->\n    <link rel=\"stylesheet\" href=\"//demo.productionready.io/main.css\">\n    <script src=\"https://cdnjs.cloudflare.com/ajax/libs/jquery/3.6.0/jquery.min.js\" integrity=\"sha512-894YE6QWD5I59HgZOGReFYm4dnWc1Qt5NtvYSaNcOP+u1T9qYdvdihz0PPSiiqn/+/3e7Jo4EaG7TubfWGUrMQ==\" crossorigin=\"anonymous\" referrerpolicy=\"no-referrer\"></script>\n</head>\n<body>\n\n<nav class=\"navbar navbar-light\">\n    <div class=\"container\">\n        <a class=\"navbar-brand\" href=\"/\">conduit</a>\n        <ul class=\"nav navbar-nav pull-xs-right\">\n            <li class=\"nav-item\">\n                <a class=\"nav-link \n                    "
if (currentUrl=="") { 
document += "\n                        active\n                    "
} 
document += "\n                \" href=\"/\">Home</a>\n            </li>\n            "
isAuth@Api(token)(isAuth)
document += "\n            "
if (isAuth==false) { 
document += "\n                <li class=\"nav-item\">\n                    <a class=\"nav-link\n                        "
if (currentUrl=="login") { 
document += "\n                            active\n                        "
} 
document += "\n                    \" href=\"/login\">Sign in</a>\n                </li>\n                <li class=\"nav-item\n                    "
if (currentUrl=="register") { 
document += "\n                        active\n                    "
} 
document += "\n                \">\n                    <a class=\"nav-link\" href=\"/register\">Sign up</a>\n                </li>\n            "
} else { 
document += "\n                <li class=\"nav-item\">\n                    <a class=\"nav-link\n                        "
if (currentUrl=="editor") { 
document += "\n                            active\n                        "
} 
document += "\n                    \" href=\"/editor\">\n                        <i class=\"ion-compose\"></i>&nbsp;New Article\n                    </a>\n                </li>\n                <li class=\"nav-item\">\n                    <a class=\"nav-link\n                        "
if (currentUrl=="settings") { 
document += "\n                            active\n                        "
} 
document += "\n                    \" href=\"/settings\">\n                        <i class=\"ion-gear-a\"></i>&nbsp;Settings\n                    </a>\n                </li>\n                "
me@Api(token)(user)
document += "\n                <li class=\"nav-item\n                    "
if (currentUrl=="settings") { 
document += "\n                        active\n                    "
} 
document += "\n                \">\n                    <a class=\"nav-link ng-binding\" href=\"/settings\">\n                      <img class=\"user-pic\" src=\""
document += user.image
document += "\">\n                      "
document += user.username
document += "\n                    </a>\n                  </li>\n            "
} 
document += "\n        </ul>\n    </div>\n</nav>\n\n"

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