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
    
}

service Main( params:Params ) {
    embed Runtime as Runtime
    embed File as File
    embed JsonUtils as JsonUtils
    embed Console as Console
    embed Api as Api 


    define operations {
        document += header.ol 
document += "\n"
document += "\n<div class=\"auth-page\">\n    <div class=\"container page\">\n        <div class=\"row\">\n\n            <div class=\"col-md-6 offset-md-3 col-xs-12\">\n                <h1 class=\"text-xs-center\">Login</h1>\n                <p class=\"text-xs-center\">\n                    <a href=\"register\">Need an account?</a>\n                </p>\n\n                "
if (request.error!=null) { 
document += "\n                    <i class=\"error-messages\">"
document += params.cookies.error
document += "</i>\n                "
} 
document += "\n\n                <form name=\"login-form\">\n                    <fieldset class=\"form-group\">\n                        <input id=\"email\" class=\"form-control form-control-lg\" type=\"text\" placeholder=\"Email\">\n                    </fieldset>\n                    <fieldset class=\"form-group\">\n                        <input id=\"password\" class=\"form-control form-control-lg\" type=\"password\" placeholder=\"Password\">\n                    </fieldset>\n                    <button type=\"submit\" class=\"btn btn-lg btn-primary pull-xs-right\">\n                        Login\n                    </button>\n                </form>\n            </div>\n        </div>\n    </div>\n</div>\n\n<script>\n$( document ).ready( function() {\n  $(\"form[name=login-form]\").submit(function(e) {\n    e.preventDefault();\n\n        $.post( \"https://api.realworld.io/api/users/login\", { user: { email: $(\"#email\").val(), password: $(\"#password\").val() } })\n            .done(function( data ) {\n                document.cookie = \"token=\" + data.user.token;\n                window.location.replace(\"/\");\n            }).fail(function($xhr) {\n                $.each($xhr.responseJSON.errors, function(key,value){\n                    document.cookie = \"error=\" + key + \" \" + value[0];\n                    console.log(key + \" \" + value[0]);\n                    window.location.replace(\"?error=true\");\n                });\n            });\n  })\n});\n</script>\n\n"
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

            
            default@Gateway( {operation = "header.ol", currentUrl << params.url, compile = false} )( header.ol ) 
default@Gateway( {operation = "layouts/footer.html", compile = false} )( layouts_footer.html ) 


            operations
            response = document
        }
    }
}