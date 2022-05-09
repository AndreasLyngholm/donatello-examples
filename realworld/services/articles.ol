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
    feed:undefined
    token?:string
    tag?:undefined
    
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
document += "
if (feed==null) { 
document += "
request.tag=tag
document += "
request.token=token
document += "
articles@Api(request)(response)
document += "
} 
document += "
if (feed=="me") { 
document += "
feed@Api(token)(response)
document += "
} 
document += "
for ( article in response.articles ) { 
document += "
document += article.author.image
document += "\"/></a>
document += article.author.username
document += "\" class=\"author\">"
document += article.author.username
document += "</a>
document += article.created_at
document += "</span>
if (article.favorited) { 
document += "
document += article.slug
document += "')\" class=\"btn btn-primary btn-sm pull-xs-right\">
document += article.favoritesCount
document += "
} else { 
document += "
document += article.slug
document += "')\" class=\"btn btn-outline-primary btn-sm pull-xs-right\">
document += article.favoritesCount
document += "
} 
document += "
document += article.slug
document += "\" class=\"preview-link\">
document += article.title
document += "</h1>
document += article.description
document += "</p>
for ( tag in article.tagList ) { 
document += "
document += tag
document += "
} 
document += "
} 
document += "
document += token
document += "'
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

            feed = params.feed 
token = params.token 
tag = params.tag 

            

            operations
            response = document
        }
    }
}