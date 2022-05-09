from GatewayInterfaceModule import GatewayInterface
from runtime import Runtime
from PageInterfaceModule import PageInterface
from file import File
from json_utils import JsonUtils
from console import Console
from string_utils import StringUtils 
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
    
}

service Main( params:Params ) {
    embed Runtime as Runtime
    embed File as File
    embed JsonUtils as JsonUtils
    embed Console as Console
    embed StringUtils as StringUtils 
embed Api as Api 


    define operations {
        document += "\n"
document += header.ol 
document += "\n"
document += "\n"
document += "\n\n<div class=\"home-page\">\n\n    <div class=\"banner\">\n        <div class=\"container\">\n            <h1 class=\"logo-font\">conduit</h1>\n            <p>A place to share your knowledge.</p>\n        </div>\n    </div>\n\n    <div class=\"container page\">\n        <div class=\"row\">\n\n            <div class=\"col-md-9\">\n                <div class=\"feed-toggle\">\n                    <ul class=\"nav nav-pills outline-active\">\n                        "
isAuth@Api(token)(isAuth)
document += "\n                        "
if (isAuth) { 
document += "\n                            <li class=\"nav-item\">\n                                <a class='nav-link "
if (request.feed=="me") { 
document += " active "
} 
document += "' href=\"?feed=me\">Your Feed</a>\n                            </li>\n                        "
} 
document += "\n                        <li class=\"nav-item\">\n                            <a class=\"nav-link "
if (request.feed==null && request.tag==null) { 
document += " active "
} 
document += "\" href=\"/\">Global Feed</a>\n                        </li>\n                        "
if (request.tag!=null) { 
document += "\n                            <li class=\"nav-item\">\n                                <a class=\"nav-link active\" href=\"?tag="
document += request.tag
document += "\">#"
document += request.tag
document += "</a>\n                            </li>\n                        "
} 
document += "\n                    </ul>\n                </div>\n\n                "
document += articles.ol 
document += "\n\n            </div>\n\n            <div class=\"col-md-3\">\n                <div class=\"sidebar\">\n                    <p>Popular Tags</p>\n\n                    <div class=\"tag-list\">\n                    "
tags@Api()(response)
document += "\n                    "
for ( tag in response.tags ) { 
document += "\n                        <a href=\"?tag="
document += tag
document += "\" class=\"tag-pill tag-default\">"
document += tag
document += "</a>\n                    "
} 
document += "\n                        \n                    </div>\n                </div>\n            </div>\n\n        </div>\n    </div>\n\n</div>\n"
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

            default@Gateway( {operation = "header.ol", token << token, currentUrl << params.url, compile = false} )( header.ol ) 
default@Gateway( {operation = "articles.ol", feed << request.feed, token << token, tag << request.tag, compile = false} )( articles.ol ) 
default@Gateway( {operation = "layouts/footer.html", compile = false} )( layouts_footer.html ) 


            operations
            response = document
        }
    }
}