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
    slug?:string
    token?:string
    
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
parameter.slug=slug
document += "
parameter.token=token
document += "
if (token!=null) { 
document += "
me@Api(token)(auth)
document += "
} 
document += "
comments@Api(parameter)(response)
document += "
for ( comment in response.comments ) { 
document += "
document += comment.body
document += "</p>
document += comment.author.image
document += "\" class=\"comment-author-img\"/>
document += comment.author.username
document += "\" class=\"comment-author\">"
document += comment.author.username
document += "</a>
document += comment.createdAt
document += "</span>
if (token!=null && auth.username==comment.author.username) { 
document += "
document += comment.id
document += ")\" class=\"ion-trash-a\"></i>
} 
document += "
} 
document += "
document += slug
document += "/comments/\" + id,
document += token
document += "'

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

            slug = params.slug 
token = params.token 

            

            operations
            response = document
        }
    }
}