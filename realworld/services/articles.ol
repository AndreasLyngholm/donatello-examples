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
        document += "\n"
document += "\n"
document += "\n"
document += "\n\n"
if (feed==null) { 
document += "\n    "
request.tag=tag
document += "\n    "
request.token=token
document += "\n    "
articles@Api(request)(response)
document += "\n"
} 
document += "\n\n"
if (feed=="me") { 
document += "\n    "
feed@Api(token)(response)
document += "\n"
} 
document += "\n\n\n"
for ( article in response.articles ) { 
document += "\n    <div class=\"article-preview\">\n        <div class=\"article-meta\">\n            <a href=\"profile.html\"><img src=\""
document += article.author.image
document += "\"/></a>\n            <div class=\"info\">\n                <a href=\"/profile/"
document += article.author.username
document += "\" class=\"author\">"
document += article.author.username
document += "</a>\n                <span class=\"date\">"
document += article.created_at
document += "</span>\n            </div>\n            "
if (article.favorited) { 
document += "\n                <button onClick=\"dislike('"
document += article.slug
document += "')\" class=\"btn btn-primary btn-sm pull-xs-right\">\n                    <i class=\"ion-heart\"></i> "
document += article.favoritesCount
document += "\n                </button>\n            "
} else { 
document += "\n                <button onClick=\"like('"
document += article.slug
document += "')\" class=\"btn btn-outline-primary btn-sm pull-xs-right\">\n                    <i class=\"ion-heart\"></i> "
document += article.favoritesCount
document += "\n                </button>\n            "
} 
document += "\n        </div>\n        <a href=\"/article/"
document += article.slug
document += "\" class=\"preview-link\">\n            <h1>"
document += article.title
document += "</h1>\n            <p>"
document += article.description
document += "</p>\n            <span>Read more...</span>\n\n            <ul class=\"tag-list\">\n                "
for ( tag in article.tagList ) { 
document += "\n                    <li class=\"tag-default tag-pill tag-outline\">\n                        "
document += tag
document += "\n                    </li>\n                "
} 
document += "\n            </ul>\n        </a>\n    </div>\n"
} 
document += "\n\n<script>\nfunction like(slug) {\n    $.ajax({\n        url: \"https://api.realworld.io/api/articles/\" + slug + \"/favorite\",\n        headers: {\n            'Authorization': 'Bearer "
document += token
document += "'\n        },\n        method: \"POST\"\n    }).done(function( data ) {\n        location.reload();\n    }).fail(function($xhr) {\n        document.cookie = \"error=\" + $xhr.responseJSON.message;\n        window.location.replace(\"?error=true\")\n    });\n}\n\nfunction dislike(slug) {\n    $.ajax({\n        url: \"https://api.realworld.io/api/articles/\" + slug + \"/favorite\",\n        headers: {\n            'Authorization': 'Bearer "
document += token
document += "'\n        },\n        method: \"DELETE\"\n    }).done(function( data ) {\n        location.reload();\n    }).fail(function($xhr) {\n        document.cookie = \"error=\" + $xhr.responseJSON.message;\n        window.location.replace(\"?error=true\")\n    });\n}\n\n</script>"

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