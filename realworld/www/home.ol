${ param token?:undefined }
${ include header.ol token=token currentUrl=params.url }
${use service string_utils}
${use service ..app.api }

<div class="home-page">

    <div class="banner">
        <div class="container">
            <h1 class="logo-font">conduit</h1>
            <p>A place to share your knowledge.</p>
        </div>
    </div>

    <div class="container page">
        <div class="row">

            <div class="col-md-9">
                <div class="feed-toggle">
                    <ul class="nav nav-pills outline-active">
                        ${ isAuth@Api(token)(isAuth) }
                        ${ if isAuth }
                            <li class="nav-item">
                                <a class='nav-link ${ if request.feed == "me" } active ${ endif }' href="?feed=me">Your Feed</a>
                            </li>
                        ${ endif }
                        <li class="nav-item">
                            <a class="nav-link ${ if request.feed == null and request.tag == null } active ${ endif }" href="/">Global Feed</a>
                        </li>
                        ${ if request.tag != null }
                            <li class="nav-item">
                                <a class="nav-link active" href="?tag={{ request.tag }}">#{{ request.tag }}</a>
                            </li>
                        ${ endif }
                    </ul>
                </div>

                ${ include articles.ol feed=request.feed token=token tag=request.tag }

            </div>

            <div class="col-md-3">
                <div class="sidebar">
                    <p>Popular Tags</p>

                    <div class="tag-list">
                    ${ tags@Api()(response) }
                    ${ for tag in response.tags }
                        <a href="?tag={{ tag }}" class="tag-pill tag-default">{{ tag }}</a>
                    ${ endfor }
                        
                    </div>
                </div>
            </div>

        </div>
    </div>

</div>
${ include layouts/footer.html }