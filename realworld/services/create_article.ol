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
    url:string
    token:string
    
}

service Main( params:Params ) {
    embed Runtime as Runtime
    embed File as File
    embed JsonUtils as JsonUtils
    embed Console as Console
    

    define operations {
        document += "\n"
document += header.ol 
document += "\n\n<div class=\"editor-page\">\n    <div class=\"container page\">\n        <div class=\"row\">\n\n            <div class=\"col-md-10 offset-md-1 col-xs-12\">\n                <form name=\"create_article\">\n                    <fieldset>\n                        <fieldset class=\"form-group\">\n                            <input id=\"title\" type=\"text\" class=\"form-control form-control-lg\" placeholder=\"Article Title\">\n                        </fieldset>\n                        <fieldset class=\"form-group\">\n                            <input id=\"description\" type=\"text\" class=\"form-control\" placeholder=\"What's this article about?\">\n                        </fieldset>\n                        <fieldset class=\"form-group\">\n                            <textarea id=\"body\" class=\"form-control\" rows=\"8\" placeholder=\"Write your article (in markdown)\"></textarea>\n                        </fieldset>\n                        <fieldset class=\"form-group\">\n                            <input id=\"tags\" type=\"text\" class=\"form-control\" placeholder=\"Enter tags\">\n                            <div class=\"tag-list\"></div>\n                        </fieldset>\n                        <button class=\"btn btn-lg pull-xs-right btn-primary\" type=\"submit\">\n                            Publish Article\n                        </button>\n                    </fieldset>\n                </form>\n            </div>\n\n        </div>\n    </div>\n</div>\n\n<script>\n$( document ).ready( function() {\n  $(\"form[name=create_article]\").submit(function(e) {\n    e.preventDefault();\n\n        $.ajax({\n            url: \"https://api.realworld.io/api/articles\",\n            headers: {\n                'Authorization': 'Bearer "
document += token
document += "'\n            },\n            method: \"POST\",\n            data: { article: { title: $(\"#title\").val(), description: $(\"#description\").val(), body: $(\"#body\").val(), tagList: $(\"#tags\").val().split(',') } }\n        }).done(function( data ) {\n            window.location.replace(\"article/\" + data.article.slug);\n        }).fail(function($xhr) {\n            document.cookie = \"error=\" + $xhr.responseJSON.message;\n            window.location.replace(\"?error=true\")\n        });\n  })\n});\n</script>\n\n"
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

            default@Gateway( {operation = "header.ol", token << token, currentUrl << params.url, compile = false} )( header.ol ) 
default@Gateway( {operation = "layouts/footer.html", compile = false} )( layouts_footer.html ) 


            operations
            response = document
        }
    }
}