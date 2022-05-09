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
    username:string
    
}

service Main( params:Params ) {
    embed Runtime as Runtime
    embed File as File
    embed JsonUtils as JsonUtils
    embed Console as Console
    embed Api as Api 


    define operations {
        document += "\n"
document += "\n\n"
document += "\n"
parameter.username=username
document += "\n"
parameter.token=token
document += "\n"
profile@Api(parameter)(profile)
document += "\n"
if (token!=null) { 
document += "\n    "
me@Api(token)(auth)
document += "\n"
} 
document += "\n\n"
document += header.ol 
document += "\n\n<div class=\"profile-page\">\n\n    <div class=\"user-info\">\n        <div class=\"container\">\n            <div class=\"row\">\n\n                <div class=\"col-xs-12 col-md-10 offset-md-1\">\n                    <img src=\""
document += profile.image
document += "\" class=\"user-img\"/>\n                    <h4>"
document += profile.username
document += "</h4>\n                    <p>\n                        "
document += profile.bio
document += "\n                    </p>\n                    <button class=\"btn btn-sm btn-outline-secondary action-btn\">\n                        <i class=\"ion-plus-round\"></i>\n                        &nbsp;\n                        Follow "
document += profile.username
document += "\n                    </button>\n                </div>\n\n            </div>\n        </div>\n    </div>\n\n    <div class=\"container\">\n        <div class=\"row\">\n\n            <div class=\"col-xs-12 col-md-10 offset-md-1\">\n            \n                "
document += articles.ol 
document += "\n\n            </div>\n\n        </div>\n    </div>\n\n</div>\n"
document += layouts_footer.html 

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
username = params.username 

            default@Gateway( {operation = "header.ol", token << token, currentUrl << params.url, compile = false} )( header.ol ) 
default@Gateway( {operation = "articles.ol", feed << request.feed, token << token, tag << request.tag, compile = false} )( articles.ol ) 
default@Gateway( {operation = "layouts/footer.html", compile = false} )( layouts_footer.html ) 


            operations
            response = document
        }
    }
}