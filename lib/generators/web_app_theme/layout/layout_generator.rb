require 'generators/web_app_theme'

module WebAppTheme
  module Generators
    class LayoutGenerator < Base

      argument :name, :type => :string, :default => 'application', :banner => "LAYOUTNAME"

      class_option :template, :type => :string, :default => 'standard', :desc => "One of the two templates: 'standard' or 'sign'."
      class_option :theme,    :type => :string, :default => 'default', :desc => "Uses the given theme."

      class_option :images,   :type => :boolean, :default => 'true', :desc => "Copies the needed images to public/images."
      class_option :js,       :type => :boolean, :default => 'true', :desc => "Copies the javascript helpers to public/javascripts."
      class_option :jquery,   :type => :boolean, :default => 'true', :desc => "Copies jquery-1.3.min.js to public/javascripts."
      class_option :locales,  :type => :boolean, :default => 'true', :desc => "Copies the locale file to config/locales."
      class_option :sass,     :type => :boolean, :default => haml?.to_s,  :desc => "Creates sass- instead of css-stylesheets."

    end
  end
end
