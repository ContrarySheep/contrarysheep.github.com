# guard-jekyll-plus
guard "jekyll-plus", :serve => true do
  watch /.*/
  ignore /^_site/
  ignore /^tags/
  ignore /^categories/
  ignore /^[0-9]/
end

# guard-livereload
guard 'livereload' do
  watch(%r{.+\.(css|html|js)$})
end

# guard-sass
guard 'sass', :input => '_sass', :output => 'css', :style => :compressed
