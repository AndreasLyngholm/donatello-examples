${use json data/articles as data}
${ include header.ol }

<div class="home-page">

    <div class="banner">
        <div class="container">
            <h1 class="logo-font">Donatello</h1>
            <p>A place to share your knowledge.</p>
        </div>
    </div>

    <div class="container page">
        <div class="row">
            <div class="col-md-12">
                ${ for article in data.articles }
                    <div class="article-preview">
                        <div class="article-meta">
                            <a href="profile.html"><img src="{{ article.author.image }}"/></a>
                            <div class="info">
                                <a href="/profile/{{ article.author.id }}" class="author">{{ article.author.name }}</a>
                                <span class="date">{{ article.date }}</span>
                            </div>
                        </div>
                        <a href="/articles/{{ article.id }}" class="preview-link">
                            <h1>{{ article.title }}</h1>
                            <p>{{ article.content }}</p>
                            <span>Read more...</span>
                        </a>
                    </div>
                ${ endfor }
            </div>
        </div>
    </div>

</div>