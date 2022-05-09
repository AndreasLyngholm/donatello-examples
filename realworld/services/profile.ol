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
        document += "
document += "
document += "
parameter.username=username
document += "
parameter.token=token
document += "
profile@Api(parameter)(profile)
document += "
if (token!=null) { 
document += "
me@Api(token)(auth)
document += "
} 
document += "
document += header.ol 
document += "
document += profile.image
document += "\" class=\"user-img\"/>
document += profile.username
document += "</h4>
document += profile.bio
document += "
document += profile.username
document += "
document += articles.ol 
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
username = params.username 

            default@Gateway( {operation = "header.ol", token << token, currentUrl << params.url, compile = false} )( header.ol ) 
default@Gateway( {operation = "articles.ol", feed << request.feed, token << token, tag << request.tag, compile = false} )( articles.ol ) 
default@Gateway( {operation = "layouts/footer.html", compile = false} )( layouts_footer.html ) 


            operations
            response = document
        }
    }
}