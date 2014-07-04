module Title
  module TitleHelper
    def title(additional_context = {})
      context = controller.view_assigns.merge(additional_context).symbolize_keys
      PageTitle.new(controller_path, action_name, context).to_s
    end

    class PageTitle
      def initialize(controller_path, action_name, context)
        @controller_path = controller_path
        @action_name = action_name
        @context = context
      end

      def to_s
        I18n.t(
          [:titles, controller_name, action_name].join('.'),
          context.merge(default: defaults)
        )
      end

      private

      attr_reader :controller_path, :action_name, :context

      def application_title
        :'titles.application'
      end

      def guess_title
        Rails.application.class.to_s.split('::').first
      end

      def defaults
        default_keys_in_lookup_path + [application_title, guess_title]
      end

      def controller_name
        controller_path.gsub('/', '.')
      end

      def default_keys_in_lookup_path
        defaults = []
        lookup_path = controller_name.split('.')
        while lookup_path.length > 0
          defaults << ['titles', *lookup_path, 'default'].join('.').to_sym
          lookup_path.pop
        end
        defaults.reverse
      end
    end
  end
end
