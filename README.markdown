# ContrarySheep README

Ain't no sheep like a contrary sheep.

# Local testing

    rvm 1.9.2@jekyll
    jekyll --server
    sass --watch _sass/main.scss:css/main.css -r ./_sass/bourbon/lib/bourbon.rb --style compressed
    
# WARNING

   Do not use the `--auto` param with Jekyll as the site will constantly regenerate because the plugins create pages in the source dir. 