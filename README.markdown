# ContrarySheep README

This project is in progress. The aim is to create a Jekyll site that is compatible with Github pages without creating multiple forks and pushing changes around those forks. To do this, there are several useful rake tasks to prepare the site locally, prior to committing changes to the repo. There is also a lot of typical Jekyll plugin functionality that has been moved to u-g-l-y Liquid template functionality.

# Local testing

    rvm 1.9.2@jekyll
    jekyll serve --watch
    sass --watch _sass/main.scss:css/main.css --style compressed
    rake
    
## Publishing

  Github pages does not allow the use of plugins, as such the `jekyll build` command is run with the `--safe` option. This will generate much of the site, but the pages for the tags and categories, must be generated locally and uploaded seperatly.

