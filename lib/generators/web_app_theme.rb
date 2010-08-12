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

      # Returns true, if Haml is in use.
      def haml?
        self.class.haml?
      end

    end
  end
end
