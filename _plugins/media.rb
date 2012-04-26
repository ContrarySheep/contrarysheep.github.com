# Derived from https://github.com/zroger/jekyll-minimagick

require 'mini_magick'

module Jekyll
  
  class GeneratedImageFile < Jekyll::StaticFile
    def initialize(site, base, dir, name, preset, source_dir)
      @site = site
      @base = base
      @dir  = dir
      @name = name
      @source_dir = source_dir
      @dst_dir = preset.delete('destination')
      @src_dir = preset.delete('source')
      @commands = preset
    end

    def path
      File.join(@base, @dir.sub(@dst_dir, @src_dir), @name)
    end

    def write(dest)
      dest_path = destination(@source_dir) #Use the @source_dir instead of dest
      
      return false if File.exist? dest_path and !modified?

      @@mtimes[path] = mtime

      FileUtils.mkdir_p(File.dirname(dest_path))
      image = ::MiniMagick::Image.open(path)
      @commands.each_pair do |command, arg|
        image.send command, arg
      end
      image.write dest_path

      true
    end

  end

  class MiniMagickGenerator
    def generate(site)
      return unless site.config['mini_magick']

      site.config['mini_magick'].each_pair do |name, preset|
        Dir.glob(File.join(preset['source'], "*.{png,jpg,jpeg,gif,tif}")) do |source|
          site.static_files << GeneratedImageFile.new(site, site.source, preset['destination'], File.basename(source), preset.clone)
        end
      end
    end
  end
  
  class Site
    def process_media
      return unless self.config['mini_magick']

      self.config['mini_magick'].each_pair do |name, preset|
        Dir.glob(File.join(preset['source'], "*.{png,jpg,jpeg,gif,tif}")) do |source|
          self.static_files << GeneratedImageFile.new(self, self.source, preset['destination'], File.basename(source), preset.clone, self.source)
          self.static_files << GeneratedImageFile.new(self, self.source, preset['destination'], File.basename(source), preset.clone, self.dest)
        end
      end
    end
  end
  
end