# Based on  https://github.com/BlackBulletIV/blackbulletiv.github.com/blob/master/_plugins/tags_categories.rb

require_relative 'custom_page'
 
module Jekyll
  class Tag < CustomPage
    def initialize(site, base, dir, tag)
      super site, base, dir, 'tag'
      self.data['tag'] = tag
      self.data['title'] = "#{site.config['tag_title_prefix'] || 'Posts tagged with '}\"#{tag}\""
      self.data['description'] = "#{site.config['tag_meta_description_prefix'] || 'Tag: '}#{tag}"
    end
  end
  
  class Tags < CustomPage
    def initialize(site, base, dir)
      super site, base, dir, 'tags'
      self.data['tags'] = site.tags.keys.sort
    end
  end
  
  class Site
        
    def generate_tags
      throw "No 'tag' layout found." unless self.layouts.key? 'tag'
      
      dir = self.config['tag_dir'] || 'tags'
      write_page Tags.new(self, self.source, dir) if self.layouts.key? 'tags'
      
      self.tags.keys.each do |tag|
        write_page Tag.new(self, self.source, File.join(dir, tag.slugize), tag)
      end
      
    end
  end
end
