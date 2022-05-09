${param token?:undefined}
${param username:string}

${use service ..app.api }
${ parameter.username = username }
${ parameter.token = token }
${ profile@Api(parameter)(profile) }
${ if token != null }
    ${ me@Api(token)(auth) }
${ endif }

${ include header.ol token=token currentUrl=params.url }

<div class="profile-page">

    <div class="user-info">
        <div class="container">
            <div class="row">

                <div class="col-xs-12 col-md-10 offset-md-1">
                    <img src="{{ profile.image }}" class="user-img"/>
                    <h4>{{ profile.username }}</h4>
                    <p>
                        {{ profile.bio }}
                    </p>
                    <button class="btn btn-sm btn-outline-secondary action-btn">
                        <i class="ion-plus-round"></i>
                        &nbsp;
                        Follow {{ profile.username }}
                    </button>
                </div>

            </div>
        </div>
    </div>

    <div class="container">
        <div class="row">

            <div class="col-xs-12 col-md-10 offset-md-1">
            
                ${ include articles.ol feed=request.feed token=token tag=request.tag }

            </div>

        </div>
    </div>

</div>
${ include layouts/footer.html }