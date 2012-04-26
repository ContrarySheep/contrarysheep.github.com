# This plugin gets added to the base Jekyll generator.

require_relative 'custom_page'

module Jekyll
  class Process < Generator
    safe true

    def generate(site)
      site.generate_archives
      site.generate_categories
      site.generate_tags
    end
  end
end