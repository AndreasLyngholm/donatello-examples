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
        document += "\n"
document += header.ol 
document += "\n\n<div class=\"home-page\">\n\n    <div class=\"banner\">\n        <div class=\"container\">\n            <h1 class=\"logo-font\">Donatello</h1>\n            <p>A place to share your knowledge.</p>\n        </div>\n    </div>\n\n    <div class=\"container page\">\n        <div class=\"row\">\n            <div class=\"col-md-12\">\n                "
for ( article in data.articles ) { 
document += "\n                    <div class=\"article-preview\">\n                        <div class=\"article-meta\">\n                            <a href=\"profile.html\"><img src=\""
document += article.author.image
document += "\"/></a>\n                            <div class=\"info\">\n                                <a href=\"/profile/"
document += article.author.id
document += "\" class=\"author\">"
document += article.author.name
document += "</a>\n                                <span class=\"date\">"
document += article.date
document += "</span>\n                            </div>\n                        </div>\n                        <a href=\"/articles/"
document += article.id
document += "\" class=\"preview-link\">\n                            <h1>"
document += article.title
document += "</h1>\n                            <p>"
document += article.content
document += "</p>\n                            <span>Read more...</span>\n                        </a>\n                    </div>\n                "
} 
document += "\n            </div>\n        </div>\n    </div>\n\n</div>"

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