from json_utils import JsonUtils
from file import File
from console import Console

type LoginRequest: void {
  email: string
  password: string
}

type MeResponse {
  ?
}

type TagsResponse {
    tags*:string
}

type ArticlesRequest {
    tag?:undefined
    token?:string
}

type CommentsRequest {
    slug?:string
    token?:string
}

type ProfileRequest {
    username?:string
    token?:string
}

type ArticlesResponse {?}

type ArticleResponse {?}

type ProfileResponse {?}

interface ApiInterface {
    RequestResponse: ping( void )( string )
    RequestResponse: login( LoginRequest )( string )
    RequestResponse: register( LoginRequest )( string )
    RequestResponse: logout( void )( void )
    RequestResponse: me( undefined )( undefined )
    RequestResponse: isAuth( undefined )( bool )

    RequestResponse: tags( void )( TagsResponse )
    RequestResponse: articles( ArticlesRequest )( ArticlesResponse )
    RequestResponse: article( CommentsRequest )( ArticleResponse )
    RequestResponse: profile( ProfileRequest )( ProfileResponse )
    RequestResponse: comments( CommentsRequest )( ArticleResponse )
    RequestResponse: feed( undefined )( ArticlesResponse )
}

service Api() {
    execution: concurrent

    embed JsonUtils as JsonUtils
    embed File as File
    embed Console as Console

    inputPort IP {
    	location: "local"
        protocol: p.protocol
        interfaces: ApiInterface
    }

    outputPort ApiPort {
        location: "socket://api.realworld.io:443/api/"
        protocol: https {
            osc << {
                ping << { alias = "ping" }
                register << { alias = "users" method = "post" }
            	login << { alias = "users/login" method = "post" }
                me << { alias = "user" method = "get" }
                tags << { alias = "tags" method = "get" }
                articles << { alias = "articles" method = "get" }
                article << { alias = "articles/{slug}" method = "get" }
                feed << { alias = "articles/feed" method = "get" }
                comments << { alias = "articles/{slug}/comments" method = "get" }
                profile << { alias = "profiles/{username}" method = "get" }
            }
        }
        interfaces: ApiInterface
    }

    main {
        [ logout ( request )( response ) {
            ApiPort.protocol.addHeader.header << null
            global.isAuth = false
        } ]

        [ isAuth ( token )( response ) {

            response = token != null

        } ]

        [ tags ( request )( response ) {

            tags@ApiPort()(response)

        } ]

        [ article ( request )( response ) {

            if(request.token != null) {
                ApiPort.protocol.addHeader.header << "Authorization" { value = "Bearer " + request.token }
            }

            ApiPort.protocol.osc.article.alias = "articles/" + request.slug

            article@ApiPort()(article_response)

            response << article_response.article

        } ]

        [ articles ( request )( response ) {

            if(request.token != null) {
                ApiPort.protocol.addHeader.header << "Authorization" { value = "Bearer " + request.token }
            }

            if(request.tag != null) {
                articles@ApiPort(request)(response)
            } else {
                articles@ApiPort()(response)
            }

        } ]

        [ comments ( request )( response ) {

            if(request.token != null) {
                ApiPort.protocol.addHeader.header << "Authorization" { value = "Bearer " + request.token }
            }

            ApiPort.protocol.osc.comments.alias = "articles/" + request.slug + "/comments"

            comments@ApiPort()(response)

        } ]

        [ profile ( request )( response ) {

            if(request.token != null) {
                ApiPort.protocol.addHeader.header << "Authorization" { value = "Bearer " + request.token }
            }

            ApiPort.protocol.osc.profile.alias = "profiles/" + request.username

            profile@ApiPort()(data)

            response << data.profile

        } ]

        [ feed ( token )( response ) {

            ApiPort.protocol.addHeader.header << "Authorization" { value = "Bearer " + token }

            feed@ApiPort()(response)

        } ]

        [ login ( request )( token ) {

            ApiPort.protocol.format = "x-www-form-urlencoded"
            login@ApiPort(request)(token)

        } ]

        [ me ( cookie )( response ) {

            ApiPort.protocol.addHeader.header << "Authorization" { value = "Bearer " + cookie }

            me@ApiPort()(user)

            response << user.user
        } ]
    }

}