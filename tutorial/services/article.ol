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
    article{?} 

}

service Main( params:Params ) {
    embed Runtime as Runtime
    embed File as File
    embed JsonUtils as JsonUtils
    embed Console as Console
    

    define operations {
        document += "\n"
document += header.ol 
document += "\n<div class=\"article-page\">\n    <div class=\"banner\">\n        <div class=\"container\">\n            <h1>"
document += article.title
document += "</h1>\n            <div class=\"article-meta\">\n                <a href=\"/profile/"
document += article.author.id
document += "\"><img src=\""
document += article.author.image
document += "\"/></a>\n                <div class=\"info\">\n                    <a href=\"/profile/"
document += article.author.id
document += "\">"
document += article.author.name
document += "</a>\n                    <span class=\"date\">"
document += article.data
document += "</span>\n                </div>\n            </div>\n        </div>\n    </div>\n\n    <div class=\"container page\">\n        <div class=\"row article-content\">\n            <div class=\"col-md-12\">\n                <p>\n                    "
document += article.content
document += "\n                </p>\n            </div>\n        </div>\n        <div class=\"row\">\n            <div class=\"col-xs-12 col-md-8 offset-md-2\">\n                <form name=\"post_comment\" class=\"card comment-form\">\n                    <div class=\"card-block\">\n                        <textarea id=\"comment\" class=\"form-control\" placeholder=\"Write a comment...\" rows=\"3\"></textarea>\n                    </div>\n                    <div class=\"card-footer\">\n                        <button type=\"submit\" class=\"btn btn-sm btn-primary\">\n                            Post Comment\n                        </button>\n                    </div>\n                </form>\n            </div>\n        </div>\n    </div>\n</div>"

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

            article << params.article 

            default@Gateway( {operation = "header.ol", compile = false} )( header.ol ) 


            operations
            response = document
        }
    }
}