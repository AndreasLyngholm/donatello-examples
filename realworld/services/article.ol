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
    slug:string
    
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
article@Api(parameter)(article)
document += "
if (token!=null) { 
document += "
me@Api(token)(auth)
document += "
} 
document += "
document += header.ol 
document += "
document += article.title
document += "</h1>
document += article.author.username
document += "\"><img src=\""
document += article.author.image
document += "\"/></a>
document += article.author.username
document += "\">"
document += article.author.username
document += "</a>
document += article.createdAt
document += "</span>
if (article.author.username!=auth.username && token!=null) { 
document += "
if (article.author.following) { 
document += "
document += article.author.username
document += "')\" class=\"btn btn-sm action-btn btn-secondary\">
document += article.author.username
document += "
} else { 
document += "
document += article.author.username
document += "')\" class=\"btn btn-sm action-btn btn-outline-secondary\">
document += article.author.username
document += "
} 
document += "
if (article.favorited) { 
document += "
document += slug
document += "')\" class=\"btn btn-sm btn-primary\">
document += article.favoritesCount
document += ")</span>
} else { 
document += "
document += slug
document += "')\" class=\"btn btn-sm btn-outline-primary\">
document += article.favoritesCount
document += ")</span>
} 
document += "
} else if (token!=null) { 
document += "
document += article.slug
document += "\">
document += article.slug
document += "')\" class=\"btn btn-outline-danger btn-sm\">
} 
document += "
document += article.body
document += "
for ( tag in article.tagList ) { 
document += "
document += tag
document += "
} 
document += "
document += article.author.username
document += "\"><img src=\""
document += article.author.image
document += "\"/></a>
document += article.author.username
document += "\" class=\"author\">"
document += article.author.username
document += "</a>
document += article.created_at
document += "</span>
if (article.author.username!=auth.username && token!=null) { 
document += "
if (article.author.following) { 
document += "
document += article.author.username
document += "')\" class=\"btn btn-sm action-btn btn-secondary\">
document += article.author.username
document += "
} else { 
document += "
document += article.author.username
document += "')\" class=\"btn btn-sm action-btn btn-outline-secondary\">
document += article.author.username
document += "
} 
document += "
if (article.favorited) { 
document += "
document += slug
document += "')\" class=\"btn btn-sm btn-outline-primary\">
document += article.favoritesCount
document += ")</span>
} else { 
document += "
document += slug
document += "')\" class=\"btn btn-sm btn-outline-primary\">
document += article.favoritesCount
document += ")</span>
} 
document += "
} else if (token!=null) { 
document += "
document += article.slug
document += "\">
document += article.slug
document += "')\" class=\"btn btn-outline-danger btn-sm\">
} 
document += "
document += auth.image
document += "\" class=\"comment-author-img\"/>
document += comments.ol 
document += "
document += article.slug
document += "/comments\",
document += token
document += "'
document += token
document += "'
document += token
document += "'
document += token
document += "'
document += token
document += "'
document += token
document += "'
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
slug = params.slug 

            default@Gateway( {operation = "header.ol", token << token, currentUrl << params.url, compile = false} )( header.ol ) 
default@Gateway( {operation = "comments.ol", slug << slug, token << token, compile = false} )( comments.ol ) 
default@Gateway( {operation = "layouts/footer.html", compile = false} )( layouts_footer.html ) 


            operations
            response = document
        }
    }
}