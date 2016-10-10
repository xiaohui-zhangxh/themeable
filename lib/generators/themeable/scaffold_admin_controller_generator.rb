module Themeable
  module Generators
    class ScaffoldAdminControllerGenerator < Rails::Generators::NamedBase

      def do_everything
        return if @options.fetch('skip_scaffold_admin', false)
        old_invocations = {}.merge(@_invocations)
        @_invocations.clear
        new_options = @options.merge('skip_scaffold_admin' => true, 'theme_template' => 'admin')
        invoke :resource_route, ["admin/#{file_path}"]
        invoke :scaffold_controller, ["admin/#{file_path}"], new_options
        @_invocations.update(old_invocations)
      end
    end
  end
end

