require 'generators/web_app_theme'
require 'rails/generators/resource_helpers'

module WebAppTheme
  module Generators
    class ScaffoldGenerator < Base
      include Rails::Generators::ResourceHelpers

      argument :attributes, :type => :array, :default => [], :banner => "field:type field:type"

      class_option :layout,    :type => :string, :desc => "Generates a layout for the controller. Choose between 'standard' and 'sign'."
      class_option :singleton, :type => :boolean, :desc => "Supply to skip index view"

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


      def create_root_folder
        empty_directory File.join("app/views", controller_file_path)
        copy_view :_sidebar, :sidebar
      end

      def copy_index_file
        return if options[:singleton]
        copy_view :index, :tables
      end

      def copy_edit_file
        copy_view :edit
      end

      def copy_show_file
        copy_view :show
      end

      def copy_new_file
        copy_view :new
      end

      def copy_form_file
        copy_view :_form, :form
      end

      def copy_layout_file
        return unless options[:layout]

        layout_name = (options[:layout] == 'standard') ? 'administration' : options[:layout]

        template File.join("..", "..", "layout", "templates", "view_layout_#{layout_name}.html.#{extension}"), File.join("app/views/layouts", controller_class_path, "#{controller_file_name}.html.#{extension}")
      end

      protected
      
      def extension
        haml? ? 'haml' : 'erb'
      end

      def copy_view(view, inview = view)
        infile = "view_#{inview}.html.#{extension}"
        outfile = "#{view}.html.#{extension}"

        template infile, File.join("app/views", controller_file_path, outfile)
      end

    end
  end
end