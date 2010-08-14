require 'generators/web_app_theme'

module WebAppTheme
  module Generators
    class LayoutGenerator < Base

      argument :name, :type => :string, :default => 'application', :banner => "LAYOUTNAME"

      class_option :template,    :type => :string, :default => 'administration', :desc => "One of the two templates: 'administration' or 'sign'."
      class_option :theme,       :type => :string, :default => 'default', :desc => "Uses the given theme."

      class_option :app_name,    :type => :string, :default => 'YourAppName', :desc => "The application name."

      class_option :images,      :type => :boolean, :default => 'true', :desc => "Copies the needed images to public/images."
      class_option :js,          :type => :boolean, :default => 'true', :desc => "Copies the javascript helpers to public/javascripts."
      class_option :jquery,      :type => :boolean, :default => 'true', :desc => "Copies jquery-1.3.min.js to public/javascripts."
      class_option :locales,     :type => :boolean, :default => 'true', :desc => "Copies the locale file to config/locales."
      class_option :stylesheets, :type => :boolean, :default => 'true', :desc => "Copies the stylesheets to public/stylesheets."
      class_option :sass,        :type => :boolean, :default => haml?.to_s,  :desc => "Creates sass- instead of css-stylesheets."


      def copy_layout_file
        template "view_layout_#{options[:template]}.html.#{extension}", File.join("app/views/layouts", "#{name}.html.#{extension}")
      end

      def copy_locales
        return unless options[:locales]

        ["config/locales/de_de.yml",
         "config/locales/pt_br.yml"].each do |file|
          copy_file file, file
        end
      end

      def copy_images
        return unless options[:images]

        copy_file File.join('images', 'avatar.png'), File.join('public', 'images', 'web-app-theme', 'avatar.png')
        
        ['application_edit.png',
         'cross.png',
         'tick.png',
         'key.png'].each do |file|
          copy_file File.join('images', 'icons', file), File.join('public', 'images', 'web-app-theme', file)
        end
      end

      def copy_jquery
        return unless options[:jquery]
        copy_file 'javascripts/jquery-1.3.min.js', 'public/javascripts/jquery-1.3.min.js'
      end

      def copy_js
        return unless options[:js]
        ['javascripts/jquery.scrollTo.js',
         'javascripts/jquery.localscroll.js'].each do |file|
          copy_file file, File.join('public', file)
        end
      end

      def copy_stylesheets
        return unless options[:js]
        if options[:sass]
          create_sass 'stylesheets/base.css', File.join('public', 'stylesheets', 'sass', 'web_app_theme.sass')
          create_sass "stylesheets/themes/#{options[:theme]}/style.css", File.join('public', 'stylesheets', 'sass', 'themes', options[:theme], 'style.sass')
          create_sass 'web_app_theme_override.css', File.join('public', 'stylesheets', 'sass', 'web_app_theme_override.sass')
        else
          copy_file 'stylesheets/base.css', File.join('public', 'stylesheets', 'web_app_theme.css')
          copy_file "stylesheets/themes/#{options[:theme]}/style.css", File.join('public', 'stylesheets', 'themes', options[:theme], 'style.css')
          copy_file 'web_app_theme_override.css', File.join('public', 'stylesheets', 'web_app_theme_override.css')
        end
      end

    end
  end
end
