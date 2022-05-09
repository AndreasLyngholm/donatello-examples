${ include header.ol currentUrl=params.url }
<div class="auth-page">
    <div class="container page">
        <div class="row">

            <div class="col-md-6 offset-md-3 col-xs-12">
                <h1 class="text-xs-center">Sign up</h1>
                <p class="text-xs-center">
                    <a href="login">Have an account?</a>
                </p>

                <form name="register-form">
                    <fieldset class="form-group">
                        <input id="username" class="form-control form-control-lg" type="text" placeholder="Username">
                    </fieldset>
                    <fieldset class="form-group">
                        <input id="email" class="form-control form-control-lg" type="text" placeholder="Email">
                    </fieldset>
                    <fieldset class="form-group">
                        <input id="password" class="form-control form-control-lg" type="password" placeholder="Password">
                    </fieldset>
                    <button class="btn btn-lg btn-primary pull-xs-right">
                        Sign up
                    </button>
                </form>
            </div>

        </div>
    </div>
</div>

<script>
$( document ).ready( function() {
  $("form[name=register-form]").submit(function(e) {
    e.preventDefault();

        $.post( "https://api.realworld.io/api/users", { user: { username: $("#username").val(), email: $("#email").val(), password: $("#password").val() } })
            .done(function( data ) {
                alert( "Data Loaded: " + data );
        });
  })
});
</script>
${ include layouts/footer.html }