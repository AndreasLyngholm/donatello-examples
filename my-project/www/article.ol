${param article{?}}
${ include header.ol }
<div class="article-page">
    <div class="banner">
        <div class="container">
            <h1>{{ article.title }}</h1>
            <div class="article-meta">
                <a href="/profile/{{ article.author.id }}"><img src="{{ article.author.image }}"/></a>
                <div class="info">
                    <a href="/profile/{{ article.author.id }}">{{ article.author.name }}</a>
                    <span class="date">{{ article.data }}</span>
                </div>
            </div>
        </div>
    </div>

    <div class="container page">
        <div class="row article-content">
            <div class="col-md-12">
                <p>
                    {{ article.content }}
                </p>
            </div>
        </div>
        <div class="row">
            <div class="col-xs-12 col-md-8 offset-md-2">
                <form name="post_comment" class="card comment-form">
                    <div class="card-block">
                        <textarea id="comment" class="form-control" placeholder="Write a comment..." rows="3"></textarea>
                    </div>
                    <div class="card-footer">
                        <button type="submit" class="btn btn-sm btn-primary">
                            Post Comment
                        </button>
                    </div>
                </form>
            </div>
        </div>
    </div>
</div>