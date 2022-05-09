${use service ..app.api }

${ param slug?:string }
${ param token?:string }

${ parameter.slug = slug }
${ parameter.token = token }

${ if token != null }
    ${ me@Api(token)(auth) }
${ endif }

${ comments@Api(parameter)(response) }

${ for comment in response.comments }
    <div class="card">
        <div class="card-block">
            <p class="card-text">{{ comment.body }}</p>
        </div>
        <div class="card-footer">
            <a href="" class="comment-author">
                <img src="{{ comment.author.image }}" class="comment-author-img"/>
            </a>
            &nbsp;
            <a href="/profile/{{ comment.author.username }}" class="comment-author">{{ comment.author.username }}</a>
            <span class="date-posted">{{ comment.createdAt }}</span>

            ${ if token != null and auth.username == comment.author.username }
                <span class="mod-options">
                  <i class="ion-edit"></i>
                  <i onClick="deleteComment({{ comment.id }})" class="ion-trash-a"></i>
                </span>
            ${ endif }
        </div>
    </div>
${ endfor }

<script>
function deleteComment(id) {
$.ajax({
    url: "https://api.realworld.io/api/articles/{{ slug }}/comments/" + id,
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