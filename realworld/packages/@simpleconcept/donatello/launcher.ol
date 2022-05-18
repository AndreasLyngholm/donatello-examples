#!/usr/bin/env jolie

from runtime import Runtime
from file import File

service Launcher () {
    embed Runtime as runtime
    embed File as file

    init {

        if(#args > 0) {
            readFile@file( {filename = args[0], format = "json"} )( config )
        }
    
        getRealServiceDirectory@file()( home )
        getFileSeparator@file()( sep )

        if( !is_defined( config.location    ) ) config.location    = "socket://localhost:8000"
        if( !is_defined( config.root        ) ) config.root        = home + sep
        if( !is_defined( config.contentDir  ) ) config.contentDir  = config.root + "www" + sep
        if( !is_defined( config.servicesDir ) ) config.servicesDir = config.root + "services" + sep
        if( !is_defined( config.defaultPage ) ) config.defaultPage = "index.ol"
        if( !is_defined( config.routes      ) ) config.routes      = config.root + "routes.json"

        loadEmbeddedService@runtime( {
            filepath = home + sep + "gateway.ol"
            service = "Gateway"
            params -> config
        } )()
    }

  main { 
        linkIn( Shutdown )
  }
}