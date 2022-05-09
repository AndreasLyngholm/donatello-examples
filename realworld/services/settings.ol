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
    
}

service Main( params:Params ) {
    embed Runtime as Runtime
    embed File as File
    embed JsonUtils as JsonUtils
    embed Console as Console
    embed Api as Api 


    define operations {
        document += "\n"
document += header.ol 
document += "\n\n"
document += "\n"
me@Api(token)(user)
document += "\n<div class=\"settings-page\">\n    <div class=\"container page\">\n        <div class=\"row\">\n\n            <div class=\"col-md-6 offset-md-3 col-xs-12\">\n                <h1 class=\"text-xs-center\">Your Settings</h1>\n\n                <form name=\"update-form\">\n                    <fieldset>\n                        <fieldset class=\"form-group\">\n                            <input id=\"image\" value=\""
document += user.image
document += "\" class=\"form-control\" type=\"text\" placeholder=\"URL of profile picture\">\n                        </fieldset>\n                        <fieldset class=\"form-group\">\n                            <input id=\"username\" value=\""
document += user.username
document += "\" class=\"form-control form-control-lg\" type=\"text\" placeholder=\"Your Name\">\n                        </fieldset>\n                        <fieldset class=\"form-group\">\n                            <textarea id=\"bio\" class=\"form-control form-control-lg\" rows=\"8\" placeholder=\"Short bio about you\">"
document += user.bio
document += "</textarea>\n                        </fieldset>\n                        <fieldset class=\"form-group\">\n                            <input id=\"email\" value=\""
document += user.email
document += "\" class=\"form-control form-control-lg\" type=\"text\" placeholder=\"Email\">\n                        </fieldset>\n\n                        "
if (request.error!=null) { 
document += "\n                            <i class=\"error-messages\">"
document += params.cookies.error
document += "</i>\n                        "
} 
document += "\n\n                        <button class=\"btn btn-lg btn-primary pull-xs-right\">\n                            Update Settings\n                        </button>\n                    </fieldset>\n                </form>\n\n                <hr>\n                <a class=\"btn btn-outline-danger\" href=\"/logout\">\n                    Or click here to logout.\n                </a>\n            </div>\n        </div>\n    </div>\n</div>\n\n<script>\n$( document ).ready( function() {\n  $(\"form[name=update-form]\").submit(function(e) {\n    e.preventDefault();\n\n        $.ajax({\n            url: \"https://api.realworld.io/api/user\",\n            headers: {\n                'Authorization': 'Bearer "
document += token
document += "'\n            },\n            method: \"PUT\",\n            data: { user: { email: $(\"#email\").val(), username: $(\"#username\").val(), bio: $(\"#bio\").val(), image: $(\"#image\").val() } }\n        }).done(function( data ) {\n            document.cookie = \"token=\" + data.user.token;\n            window.location.replace(\"?updated=success\");\n        }).fail(function($xhr) {\n            document.cookie = \"error=\" + $xhr.responseJSON.message;\n            window.location.replace(\"?error=true\")\n        });\n  })\n});\n</script>\n\n"
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