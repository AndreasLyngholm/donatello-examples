${use service ..app.api }
${param feed:undefined }
${param token?:string }
${param tag?:undefined }

${ if feed == null }
    ${request.tag = tag}
    ${request.token = token}
    ${ articles@Api(request)(response) }
${ endif }

${ if feed == "me" }
    ${ feed@Api(token)(response) }
${ endif }


${ for article in response.articles }
    <div class="article-preview">
        <div class="article-meta">
            <a href="profile.html"><img src="{{ article.author.image }}"/></a>
            <div class="info">
                <a href="/profile/{{ article.author.username }}" class="author">{{ article.author.username }}</a>
                <span class="date">{{ article.created_at }}</span>
            </div>
            ${ if article.favorited }
                <button onClick="dislike('{{ article.slug }}')" class="btn btn-primary btn-sm pull-xs-right">
                    <i class="ion-heart"></i> {{ article.favoritesCount }}
                </button>
            ${ else }
                <button onClick="like('{{ article.slug }}')" class="btn btn-outline-primary btn-sm pull-xs-right">
                    <i class="ion-heart"></i> {{ article.favoritesCount }}
                </button>
            ${ endif }
        </div>
        <a href="/article/{{ article.slug }}" class="preview-link">
            <h1>{{ article.title }}</h1>
            <p>{{ article.description }}</p>
            <span>Read more...</span>

            <ul class="tag-list">
                ${ for tag in article.tagList }
                    <li class="tag-default tag-pill tag-outline">
                        {{ tag }}
                    </li>
                ${ endfor }
            </ul>
        </a>
    </div>
${ endfor }

<script>
function like(slug) {
    $.ajax({
        url: "https://api.realworld.io/api/articles/" + slug + "/favorite",
        headers: {
            'Authorization': 'Bearer {{ token }}'
        },
        method: "POST"
    }).done(function( data ) {
        location.reload();
    }).fail(function($xhr) {
        document.cookie = "error=" + $xhr.responseJSON.message;
        window.location.replace("?error=true")
    });
}

function dislike(slug) {
    $.ajax({
        url: "https://api.realworld.io/api/articles/" + slug + "/favorite",
        headers: {
            'Authorization': 'Bearer {{ token }}'
        },
        method: "DELETE"
    }).done(function( data ) {
        location.reload();
    }).fail(function($xhr) {
        document.cookie = "error=" + $xhr.responseJSON.message;
        window.location.replace("?error=true")
    });
}

</script>