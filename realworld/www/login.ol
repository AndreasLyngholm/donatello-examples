${ include header.ol currentUrl=params.url }
${use service ..app.api }
<div class="auth-page">
    <div class="container page">
        <div class="row">

            <div class="col-md-6 offset-md-3 col-xs-12">
                <h1 class="text-xs-center">Login</h1>
                <p class="text-xs-center">
                    <a href="register">Need an account?</a>
                </p>

                ${ if request.error != null }
                    <i class="error-messages">{{ params.cookies.error }}</i>
                ${ endif }

                <form name="login-form">
                    <fieldset class="form-group">
                        <input id="email" class="form-control form-control-lg" type="text" placeholder="Email">
                    </fieldset>
                    <fieldset class="form-group">
                        <input id="password" class="form-control form-control-lg" type="password" placeholder="Password">
                    </fieldset>
                    <button type="submit" class="btn btn-lg btn-primary pull-xs-right">
                        Login
                    </button>
                </form>
            </div>
        </div>
    </div>
</div>

<script>
$( document ).ready( function() {
  $("form[name=login-form]").submit(function(e) {
    e.preventDefault();

        $.post( "https://api.realworld.io/api/users/login", { user: { email: $("#email").val(), password: $("#password").val() } })
            .done(function( data ) {
                document.cookie = "token=" + data.user.token;
                window.location.replace("/");
            }).fail(function($xhr) {
                $.each($xhr.responseJSON.errors, function(key,value){
                    document.cookie = "error=" + key + " " + value[0];
                    console.log(key + " " + value[0]);
                    window.location.replace("?error=true");
                });
            });
  })
});
</script>

${ include layouts/footer.html }