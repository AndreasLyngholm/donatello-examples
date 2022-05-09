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
    
}

service Main( params:Params ) {
    embed Runtime as Runtime
    embed File as File
    embed JsonUtils as JsonUtils
    embed Console as Console
    

    define operations {
        document += header.ol 
document += "\n<div class=\"auth-page\">\n    <div class=\"container page\">\n        <div class=\"row\">\n\n            <div class=\"col-md-6 offset-md-3 col-xs-12\">\n                <h1 class=\"text-xs-center\">Sign up</h1>\n                <p class=\"text-xs-center\">\n                    <a href=\"login\">Have an account?</a>\n                </p>\n\n                <form name=\"register-form\">\n                    <fieldset class=\"form-group\">\n                        <input id=\"username\" class=\"form-control form-control-lg\" type=\"text\" placeholder=\"Username\">\n                    </fieldset>\n                    <fieldset class=\"form-group\">\n                        <input id=\"email\" class=\"form-control form-control-lg\" type=\"text\" placeholder=\"Email\">\n                    </fieldset>\n                    <fieldset class=\"form-group\">\n                        <input id=\"password\" class=\"form-control form-control-lg\" type=\"password\" placeholder=\"Password\">\n                    </fieldset>\n                    <button class=\"btn btn-lg btn-primary pull-xs-right\">\n                        Sign up\n                    </button>\n                </form>\n            </div>\n\n        </div>\n    </div>\n</div>\n\n<script>\n$( document ).ready( function() {\n  $(\"form[name=register-form]\").submit(function(e) {\n    e.preventDefault();\n\n        $.post( \"https://api.realworld.io/api/users\", { user: { username: $(\"#username\").val(), email: $(\"#email\").val(), password: $(\"#password\").val() } })\n            .done(function( data ) {\n                alert( \"Data Loaded: \" + data );\n        });\n  })\n});\n</script>\n"
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