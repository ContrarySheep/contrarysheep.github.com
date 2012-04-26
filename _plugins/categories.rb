# Based on  https://github.com/BlackBulletIV/blackbulletiv.github.com/blob/master/_plugins/tags_categories.rb

require_relative 'custom_page'
 
module Jekyll
  class Category < CustomPage
    def initialize(site, base, dir, category)
      super site, base, dir, 'category'
      self.data['category'] = category
      self.data['title'] = "#{site.config['category_title_prefix'] || 'Posts in the '}\"#{category}\" category"
      self.data['description'] = "#{site.config['category_meta_description_prefix'] || 'Category: '}#{category}"
    end
  end
  
  class Categories < CustomPage
    def initialize(site, base, dir)
      super site, base, dir, 'categories'
      self.data['categories'] = site.categories.keys.sort
    end
  end
  
  class Site
        
    def generate_categories
      throw "No 'category' layout found." unless self.layouts.key? 'category'
      
      dir = self.config['category_dir'] || 'categories'
      write_page Categories.new(self, self.source, dir) if self.layouts.key? 'categories'
      
      self.categories.keys.each do |category|
        write_page Category.new(self, self.source, File.join(dir, category.slugize), category)
      end
      
    end
  end
end
