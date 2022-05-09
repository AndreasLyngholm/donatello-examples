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
        document += "
document += header.ol 
document += "
for ( article in data.articles ) { 
document += "
document += article.author.image
document += "\"/></a>
document += article.author.id
document += "\" class=\"author\">"
document += article.author.name
document += "</a>
document += article.date
document += "</span>
document += article.id
document += "\" class=\"preview-link\">
document += article.title
document += "</h1>
document += article.content
document += "</p>
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

            
            readFile@File( {filename = params.root + "data/articles.json", format = "json"} )( data ) 
default@Gateway( {operation = "header.ol", compile = false} )( header.ol ) 


            operations
            response = document
        }
    }
}