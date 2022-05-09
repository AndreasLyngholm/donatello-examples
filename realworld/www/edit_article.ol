${ param slug:string }
${ param token:string }

${use service ..app.api }
${ data.slug = slug }
${ data.token = token }
${ article@Api(data)(article) }
${ if token != null }
    ${ me@Api(token)(auth) }
${ endif }

${ include header.ol token=token currentUrl=params.url }

<div class="editor-page">
    <div class="container page">
        <div class="row">

            <div class="col-md-10 offset-md-1 col-xs-12">
                <form name="edit_article">
                    <fieldset>
                        <fieldset class="form-group">
                            <input id="title" value="{{ article.title }}" type="text" class="form-control form-control-lg" placeholder="Article Title">
                        </fieldset>
                        <fieldset class="form-group">
                            <input id="description" value="{{ article.description }}" type="text" class="form-control" placeholder="What's this article about?">
                        </fieldset>
                        <fieldset class="form-group">
                            <textarea id="body" class="form-control" rows="8" placeholder="Write your article (in markdown)">{{ article.body }}</textarea>
                        </fieldset>
                        <button class="btn btn-lg pull-xs-right btn-primary" type="submit">
                            Edit Article
                        </button>
                    </fieldset>
                </form>
            </div>

        </div>
    </div>
</div>

<script>
$( document ).ready( function() {
  $("form[name=edit_article]").submit(function(e) {
    e.preventDefault();

        $.ajax({
            url: "https://api.realworld.io/api/articles/{{ slug }}",
            headers: {
                'Authorization': 'Bearer {{ token }}'
            },
            method: "PUT",
            data: { article: { title: $("#title").val(), description: $("#description").val(), body: $("#body").val() } }
        }).done(function( data ) {
            window.location.replace("/article/" + data.article.slug);
        }).fail(function($xhr) {
            document.cookie = "error=" + $xhr.responseJSON.message;
            window.location.replace("?error=true")
        });
  })
});
</script>

${ include layouts/footer.html }