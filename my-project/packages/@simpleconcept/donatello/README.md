# The Donatello Web Server
This is Donatello, a dynamic web service written in <a href="https://www.jolie-lang.org/">Jolie</a>.

You can use Donatello as is, to host dynamic content in the Donatello Templating language or simply as a host for static pages.

Donatello uses plain HTTP for serving content. To add encryption (HTTPS), we recommend combining it with a reverse proxy (for example, we like linuxserver/letsencrypt).

<!--
# Quickstart guide (Docker)
With Docker, you can get started very quickly. First, pull the latest image: `docker pull lyngholm/donatello`.

```
docker run -it --rm -v "$(pwd)"/myWWW:/web -e LEONARDO_WWW=/web -p 8080:8080 lyngholm/donatello
```
Browse to <a href="">http://localhost:8080/</a>.
-->

# Quickstart guide (Linux)
For this part, we assume that you have <a href="https://www.jolie-lang.org/">Jolie</a> installed on you machine.

To run Donatello, you will have to declare where the content of your web server is stored. This can be done in two ways:
- Pass the content directory as an argument. For example, if your content is in `/var/www`, then you should run the command `jolie launcher.ol /var/www`.
- Pass the content directory by using the environment variable `DONATELLO_WWW`. In this case, you just need to invoke `jolie launcher.ol`.

# Examples

## Basic tags
### Assigning variables
```
...
${ x = 123}
${ y = x + 123}
...
```
<i>This will not print anything to the page, but the variables will be available to print and/or manipulate.</i>

### Printing variables
```
...
${ x = 123} // This is not for printing, but just to assign a variable for us to print.
{{ x }}
...
```

## Import data/services
### Import JSON
```
${ use json data/user as user }

<h1>Welcome, {{ user.name }}</h1>
```
<i>From the syntax, it is assumed that there is a json file at the location; data/, naming user.json.</i>
### Import Service
```
${ use service time }
...
${getCurrentDateTime@Time()(time)}

<p>The time is: {{ time }}</p>
...
```
<i>In this case, the service is a built-in Jolie service, but it could be any Jolie service.</i>

## Include files/templates
### Basic inclusion without params
```
${ include layout/header.html }
```

```
${ include menu.ol }
```

### Include service as content with params
#### menu.ol
```
${param name:string}
<h1>Welcome, {{ name }}</h1>
```

#### user.ol

```
${ use json data/user as user }
...
${ include menu.ol name=user.name }
...
```


## Control flow
### If/else statements
```
${ use json data/user as user }
...
${ if user.age > 10 }

  <h1>Welcome, {{ user.name }}</h1>

${ else }

  <h1>Bye, {{ user.name }}</h1>

${ endif }
...
```

### Foreach statements
${use json data/users as data}
```
...
<h1>List of all users...</h1>

${ for user in data.users }

  <p>Hi, {{ user.name }} your age is {{ user.age }}</p>

${ endfor }
...
```
