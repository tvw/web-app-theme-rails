require 'generators/web_app_theme'
require 'rails/generators/resource_helpers'

module WebAppTheme
  module Generators
    class ScaffoldGenerator < Base
      include Rails::Generators::ResourceHelpers

      argument :attributes, :type => :array, :default => [], :banner => "field:type field:type"

      class_option :style,     :type => :string, :default => 'web_app_theme', :desc => "'web_app_theme'-views or the normal 'rails'-views"
      class_option :singleton, :type => :boolean, :desc => "Supply to skip index view"

      hook_for :layout, :as => 'web_app_theme', :type => :boolean, :desc => "Generates a web_app_theme:layout for the controller with the same name as the controller."

      def create_root_folder
        empty_directory File.join("app/views", controller_file_path)
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

      def copy_sidebar
        return unless options[:style] == "web_app_theme"
        copy_view :_sidebar, :sidebar
      end

      protected
      
      def copy_view(view, inview = view)
        infile = (options[:style] == "web_app_theme") ? "web_app_theme/view_#{inview}.html.#{extension}" : "rails/#{view}.html.#{extension}"
        outfile = "#{view}.html.#{extension}"

        template infile, File.join("app/views", controller_file_path, outfile)
      end

    end
  end
end
