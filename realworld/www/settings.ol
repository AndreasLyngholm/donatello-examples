${ param token?:undefined }
${ include header.ol token=token currentUrl=params.url }

${use service ..app.api }
${ me@Api(token)(user) }
<div class="settings-page">
    <div class="container page">
        <div class="row">

            <div class="col-md-6 offset-md-3 col-xs-12">
                <h1 class="text-xs-center">Your Settings</h1>

                <form name="update-form">
                    <fieldset>
                        <fieldset class="form-group">
                            <input id="image" value="{{ user.image }}" class="form-control" type="text" placeholder="URL of profile picture">
                        </fieldset>
                        <fieldset class="form-group">
                            <input id="username" value="{{ user.username }}" class="form-control form-control-lg" type="text" placeholder="Your Name">
                        </fieldset>
                        <fieldset class="form-group">
                            <textarea id="bio" class="form-control form-control-lg" rows="8" placeholder="Short bio about you">{{ user.bio }}</textarea>
                        </fieldset>
                        <fieldset class="form-group">
                            <input id="email" value="{{ user.email }}" class="form-control form-control-lg" type="text" placeholder="Email">
                        </fieldset>

                        ${ if request.error != null }
                            <i class="error-messages">{{ params.cookies.error }}</i>
                        ${ endif }

                        <button class="btn btn-lg btn-primary pull-xs-right">
                            Update Settings
                        </button>
                    </fieldset>
                </form>

                <hr>
                <a class="btn btn-outline-danger" href="/logout">
                    Or click here to logout.
                </a>
            </div>
        </div>
    </div>
</div>

<script>
$( document ).ready( function() {
  $("form[name=update-form]").submit(function(e) {
    e.preventDefault();

        $.ajax({
            url: "https://api.realworld.io/api/user",
            headers: {
                'Authorization': 'Bearer {{ token }}'
            },
            method: "PUT",
            data: { user: { email: $("#email").val(), username: $("#username").val(), bio: $("#bio").val(), image: $("#image").val() } }
        }).done(function( data ) {
            document.cookie = "token=" + data.user.token;
            window.location.replace("?updated=success");
        }).fail(function($xhr) {
            document.cookie = "error=" + $xhr.responseJSON.message;
            window.location.replace("?error=true")
        });
  })
});
</script>

${ include layouts/footer.html }