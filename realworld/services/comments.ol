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
        document += "\n\n"
document += "\n"
document += "\n\n"
parameter.slug=slug
document += "\n"
parameter.token=token
document += "\n\n"
if (token!=null) { 
document += "\n    "
me@Api(token)(auth)
document += "\n"
} 
document += "\n\n"
comments@Api(parameter)(response)
document += "\n\n"
for ( comment in response.comments ) { 
document += "\n    <div class=\"card\">\n        <div class=\"card-block\">\n            <p class=\"card-text\">"
document += comment.body
document += "</p>\n        </div>\n        <div class=\"card-footer\">\n            <a href=\"\" class=\"comment-author\">\n                <img src=\""
document += comment.author.image
document += "\" class=\"comment-author-img\"/>\n            </a>\n            &nbsp;\n            <a href=\"/profile/"
document += comment.author.username
document += "\" class=\"comment-author\">"
document += comment.author.username
document += "</a>\n            <span class=\"date-posted\">"
document += comment.createdAt
document += "</span>\n\n            "
if (token!=null && auth.username==comment.author.username) { 
document += "\n                <span class=\"mod-options\">\n                  <i class=\"ion-edit\"></i>\n                  <i onClick=\"deleteComment("
document += comment.id
document += ")\" class=\"ion-trash-a\"></i>\n                </span>\n            "
} 
document += "\n        </div>\n    </div>\n"
} 
document += "\n\n<script>\nfunction deleteComment(id) {\n$.ajax({\n    url: \"https://api.realworld.io/api/articles/"
document += slug
document += "/comments/\" + id,\n    headers: {\n        'Authorization': 'Bearer "
document += token
document += "'\n    },\n    method: \"DELETE\"\n}).done(function( data ) {\n    location.reload();\n}).fail(function($xhr) {\n    document.cookie = \"error=\" + $xhr.responseJSON.message;\n    window.location.replace(\"?error=true\")\n});\n}\n</script>"

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