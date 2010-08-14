require 'rails/generators/named_base'

module WebAppTheme
  module Generators
    class Base < Rails::Generators::NamedBase
      # Automatically sets the source root based on the class name.
      def self.source_root
        @_web_app_theme_source_root ||= begin
          File.expand_path(File.join(File.dirname(__FILE__), 'web_app_theme', generator_name, 'templates')) if generator_name
        end
      end

      # Returns true, if Haml is in use.
      def self.haml?
        if RUBY_VERSION < '1.9'
          Module.constants.include?('Haml')
        else
          Module.constants.include?(:Haml)
        end
      end

      class_option :type, :type => :string, :default => (haml? ? 'haml' : 'erb'), :desc => "Choose the type of templates you want to generate."

      protected
      
      # File extension: 'haml' or 'erb'.
      def extension
        haml? ? 'haml' : 'erb'
      end

      # Returns true, if Haml is in use.
      def haml?
        self.class.haml?
      end

      # Gets a CSS file at the relative source, converts it to Sass and makes a copy
      # at the relative destination. If the destination is not given it's assumed
      # to be equal to the source replacing .css by .sass in the filename.
      #
      # ==== Parameters
      # source<String>:: the relative path to the source root.
      # destination<String>:: the relative path to the destination root.
      # config<Hash>:: give :verbose => false to not log the status.
      #
      # ==== Examples
      #
      #   create_sass "README", "doc/README"
      #
      #   create_sass "doc/README"
      #
      def create_sass(source, *args, &block)
        require 'sass/css'

        config = args.last.is_a?(Hash) ? args.pop : {}
        destination = args.first || source.gsub(/\.css/,'.sass')
 
        source  = File.expand_path(find_in_source_paths(source.to_s))
        source_file = IO.read(source)
 
        create_file destination, nil, config do
          content = Sass::CSS.new(source_file).render(:sass)
          content = block.call(content) if block
          content
        end
      end


      # for web_app_theme templates
      def controller_routing_path
        plural_name
      end

      # for web_app_theme templates
      def singular_controller_routing_path
        singular_name
      end

      # for web_app_theme templates
      def resource_name
        singular_name
      end

      # for web_app_theme templates
      def plural_resource_name
        plural_name
      end

      # for web_app_theme templates
      def model_name
        singular_name
      end

      # for web_app_theme templates
      def plural_model_name
        plural_name
      end

      # for web_app_theme templates
      def columns
        attributes
      end

    end
  end
end
