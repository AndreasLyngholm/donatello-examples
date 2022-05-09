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
        document += "
document += header.ol 
document += "
document += "
document += "
isAuth@Api(token)(isAuth)
document += "
if (isAuth) { 
document += "
if (request.feed=="me") { 
document += " active "
} 
document += "' href=\"?feed=me\">Your Feed</a>
} 
document += "
if (request.feed==null && request.tag==null) { 
document += " active "
} 
document += "\" href=\"/\">Global Feed</a>
if (request.tag!=null) { 
document += "
document += request.tag
document += "\">#"
document += request.tag
document += "</a>
} 
document += "
document += articles.ol 
document += "
tags@Api()(response)
document += "
for ( tag in response.tags ) { 
document += "
document += tag
document += "\" class=\"tag-pill tag-default\">"
document += tag
document += "</a>
} 
document += "
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