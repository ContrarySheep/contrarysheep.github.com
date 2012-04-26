# Based on  https://github.com/BlackBulletIV/blackbulletiv.github.com/blob/master/_plugins/custom_page.rb

module Jekyll
  class CustomPage < Page
    def initialize(site, base, dir, layout)
      @site = site
      @base = base
      @dir  = dir
      @name = 'index.html'
      
      self.process(@name)
      self.read_yaml(File.join(base, '_layouts'), layout + '.html')
    end
  end
  
  class Site
    def write_page(page)
      page.render(self.layouts, site_payload)
      page.write(self.source)
      self.pages << page
    end
  end
end