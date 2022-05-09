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
        document += "\n"
document += "\n\n"
document += "\n"
parameter.slug=slug
document += "\n"
parameter.token=token
document += "\n"
article@Api(parameter)(article)
document += "\n"
if (token!=null) { 
document += "\n    "
me@Api(token)(auth)
document += "\n"
} 
document += "\n\n"
document += header.ol 
document += "\n<div class=\"article-page\">\n\n    <div class=\"banner\">\n        <div class=\"container\">\n\n            <h1>"
document += article.title
document += "</h1>\n\n            <div class=\"article-meta\">\n                <a href=\"/profile/"
document += article.author.username
document += "\"><img src=\""
document += article.author.image
document += "\"/></a>\n                <div class=\"info\">\n                    <a href=\"/profile/"
document += article.author.username
document += "\">"
document += article.author.username
document += "</a>\n                    <span class=\"date\">"
document += article.createdAt
document += "</span>\n                </div>\n                \n                "
if (article.author.username!=auth.username && token!=null) { 
document += "\n                    "
if (article.author.following) { 
document += "\n                        <button onClick=\"unfollow('"
document += article.author.username
document += "')\" class=\"btn btn-sm action-btn btn-secondary\">\n                            <i class=\"ion-heart\"></i>\n                            &nbsp;\n                            Unfollow "
document += article.author.username
document += "\n                        </button>\n                    "
} else { 
document += "\n                        <button onClick=\"follow('"
document += article.author.username
document += "')\" class=\"btn btn-sm action-btn btn-outline-secondary\">\n                            <i class=\"ion-plus-round\"></i>\n                            &nbsp;\n                            Follow "
document += article.author.username
document += "\n                        </button>\n                    "
} 
document += "\n                    &nbsp;\n                    "
if (article.favorited) { 
document += "\n                        <button onClick=\"dislike('"
document += slug
document += "')\" class=\"btn btn-sm btn-primary\">\n                            <i class=\"ion-heart\"></i>\n                            &nbsp;\n                            Unfavorite Post <span class=\"counter\">("
document += article.favoritesCount
document += ")</span>\n                        </button>\n                    "
} else { 
document += "\n                        <button onClick=\"like('"
document += slug
document += "')\" class=\"btn btn-sm btn-outline-primary\">\n                            <i class=\"ion-heart\"></i>\n                            &nbsp;\n                            Favorite Post <span class=\"counter\">("
document += article.favoritesCount
document += ")</span>\n                        </button>\n                    "
} 
document += "\n                "
} else if (token!=null) { 
document += "\n\n                    <a class=\"btn btn-outline-secondary btn-sm\" href=\"/editor/"
document += article.slug
document += "\">\n                        <i class=\"ion-edit\"></i> Edit Article\n                    </a>\n\n                    <button onClick=\"deleteArticle('"
document += article.slug
document += "')\" class=\"btn btn-outline-danger btn-sm\">\n                        <i class=\"ion-trash-a\"></i> Delete Article\n                    </button>\n\n                "
} 
document += "\n            </div>\n\n        </div>\n    </div>\n\n    <div class=\"container page\">\n\n        <div class=\"row article-content\">\n            <div class=\"col-md-12\">\n                <p>\n                    "
document += article.body
document += "\n                </p>\n            </div>\n        </div>\n\n        <ul class=\"tag-list\">\n\n        "
for ( tag in article.tagList ) { 
document += "\n            <li class=\"tag-default tag-pill tag-outline\">\n                "
document += tag
document += "\n            </li>\n        "
} 
document += "\n\n        </ul>\n\n        <hr/>\n\n        <div class=\"article-actions\">\n            <div class=\"article-meta\">\n                <a href=\"/profile/"
document += article.author.username
document += "\"><img src=\""
document += article.author.image
document += "\"/></a>\n                <div class=\"info\">\n                    <a href=\"/profile/"
document += article.author.username
document += "\" class=\"author\">"
document += article.author.username
document += "</a>\n                    <span class=\"date\">"
document += article.created_at
document += "</span>\n                </div>\n\n                "
if (article.author.username!=auth.username && token!=null) { 
document += "\n                    "
if (article.author.following) { 
document += "\n                        <button onClick=\"unfollow('"
document += article.author.username
document += "')\" class=\"btn btn-sm action-btn btn-secondary\">\n                            <i class=\"ion-heart\"></i>\n                            &nbsp;\n                            Unfollow "
document += article.author.username
document += "\n                        </button>\n                    "
} else { 
document += "\n                        <button onClick=\"follow('"
document += article.author.username
document += "')\" class=\"btn btn-sm action-btn btn-outline-secondary\">\n                            <i class=\"ion-plus-round\"></i>\n                            &nbsp;\n                            Follow "
document += article.author.username
document += "\n                        </button>\n                    "
} 
document += "\n                    &nbsp;\n                    "
if (article.favorited) { 
document += "\n                        <button onClick=\"dislike('"
document += slug
document += "')\" class=\"btn btn-sm btn-outline-primary\">\n                            <i class=\"ion-heart\"></i>\n                            &nbsp;\n                            Unfavorite Post <span class=\"counter\">("
document += article.favoritesCount
document += ")</span>\n                        </button>\n                    "
} else { 
document += "\n                        <button onClick=\"like('"
document += slug
document += "')\" class=\"btn btn-sm btn-outline-primary\">\n                            <i class=\"ion-heart\"></i>\n                            &nbsp;\n                            Favorite Post <span class=\"counter\">("
document += article.favoritesCount
document += ")</span>\n                        </button>\n                    "
} 
document += "\n                "
} else if (token!=null) { 
document += "\n\n                    <a class=\"btn btn-outline-secondary btn-sm\" href=\"/editor/"
document += article.slug
document += "\">\n                        <i class=\"ion-edit\"></i> Edit Article\n                    </a>\n\n                    <button onClick=\"deleteArticle('"
document += article.slug
document += "')\" class=\"btn btn-outline-danger btn-sm\">\n                        <i class=\"ion-trash-a\"></i> Delete Article\n                    </button>\n\n                "
} 
document += "\n            </div>\n        </div>\n\n        <div class=\"row\">\n\n            <div class=\"col-xs-12 col-md-8 offset-md-2\">\n\n                <form name=\"post_comment\" class=\"card comment-form\">\n                    <div class=\"card-block\">\n                        <textarea id=\"comment\" class=\"form-control\" placeholder=\"Write a comment...\" rows=\"3\"></textarea>\n                    </div>\n                    <div class=\"card-footer\">\n                        <img src=\""
document += auth.image
document += "\" class=\"comment-author-img\"/>\n                        <button type=\"submit\" class=\"btn btn-sm btn-primary\">\n                            Post Comment\n                        </button>\n                    </div>\n                </form>\n\n                "
document += comments.ol 
document += "\n\n            </div>\n\n        </div>\n\n    </div>\n\n</div>\n\n<script>\n$( document ).ready( function() {\n  $(\"form[name=post_comment]\").submit(function(e) {\n    e.preventDefault();\n\n        $.ajax({\n            url: \"https://api.realworld.io/api/articles/"
document += article.slug
document += "/comments\",\n            headers: {\n                'Authorization': 'Bearer "
document += token
document += "'\n            },\n            method: \"POST\",\n            data: { comment: { body: $(\"#comment\").val() } }\n        }).done(function( data ) {\n            location.reload();\n        }).fail(function($xhr) {\n            document.cookie = \"error=\" + $xhr.responseJSON.message;\n            window.location.replace(\"?error=true\")\n        });\n  })\n});\n\nfunction deleteArticle(slug) {\n    $.ajax({\n        url: \"https://api.realworld.io/api/articles/\" + slug,\n        headers: {\n            'Authorization': 'Bearer "
document += token
document += "'\n        },\n        method: \"DELETE\"\n    }).done(function( data ) {\n        window.location.replace(\"/\");\n    }).fail(function($xhr) {\n        document.cookie = \"error=\" + $xhr.responseJSON.message;\n        window.location.replace(\"?error=true\")\n    });\n}\n\nfunction like(slug) {\n    $.ajax({\n        url: \"https://api.realworld.io/api/articles/\" + slug + \"/favorite\",\n        headers: {\n            'Authorization': 'Bearer "
document += token
document += "'\n        },\n        method: \"POST\"\n    }).done(function( data ) {\n        location.reload();\n    }).fail(function($xhr) {\n        document.cookie = \"error=\" + $xhr.responseJSON.message;\n        window.location.replace(\"?error=true\")\n    });\n}\n\nfunction dislike(slug) {\n    $.ajax({\n        url: \"https://api.realworld.io/api/articles/\" + slug + \"/favorite\",\n        headers: {\n            'Authorization': 'Bearer "
document += token
document += "'\n        },\n        method: \"DELETE\"\n    }).done(function( data ) {\n        location.reload();\n    }).fail(function($xhr) {\n        document.cookie = \"error=\" + $xhr.responseJSON.message;\n        window.location.replace(\"?error=true\")\n    });\n}\n\nfunction follow(username) {\n    $.ajax({\n        url: \"https://api.realworld.io/api/profiles/\" + username + \"/follow\",\n        headers: {\n            'Authorization': 'Bearer "
document += token
document += "'\n        },\n        method: \"POST\"\n    }).done(function( data ) {\n        location.reload();\n    }).fail(function($xhr) {\n        document.cookie = \"error=\" + $xhr.responseJSON.message;\n        window.location.replace(\"?error=true\")\n    });\n}\n\nfunction unfollow(username) {\n    $.ajax({\n        url: \"https://api.realworld.io/api/profiles/\" + username + \"/follow\",\n        headers: {\n            'Authorization': 'Bearer "
document += token
document += "'\n        },\n        method: \"DELETE\"\n    }).done(function( data ) {\n        location.reload();\n    }).fail(function($xhr) {\n        document.cookie = \"error=\" + $xhr.responseJSON.message;\n        window.location.replace(\"?error=true\")\n    });\n}\n\n</script>\n\n"
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