# Based on  https://github.com/BlackBulletIV/blackbulletiv.github.com/blob/master/_plugins/filters.rb

module Jekyll
  module Filters
    def slugize(text)
      text.slugize
    end
    
    def format_date(date)
      "#{date.strftime('%B')} #{date.strftime('%-d')}, #{date.strftime('%Y')}"
    end
    
    def length(obj)
      obj.length if obj.respond_to? :length
    end
    
  end
end

class String
  def slugize
    self.downcase.gsub(/[\s\.]/, '-').gsub(/[^\w\d\-]/, '')
  end
end