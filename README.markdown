# ContrarySheep README

This project is in progress. The aim is to create a Jekyll site that is compatible with Github pages without creating multiple forks and pushing changes around those forks. To do this, there are several useful rake tasks to prepare the site locally, prior to committing changes to the repo. There is also a lot of typical Jekyll plugin functionality that has been moved to u-g-l-y Liquid template functionality.

# Local testing

    rvm 1.9.2@jekyll
    jekyll --server --auto
    sass --watch _sass/main.scss:css/main.css -r ./_sass/bourbon/lib/bourbon.rb --style compressed
    rake
    
