module Title
  module TitleHelper
    SEPARATOR = ' - '.freeze

    def title(additional_context = {})
      include_application_name = additional_context.delete(:include_application_name)
      context = controller.view_assigns.merge(additional_context).symbolize_keys
      PageTitle.new(controller_path, action_name, context, include_application_name).to_s
    end

    class PageTitle
      def initialize(controller_path, action_name, context, include_application_name)
        @controller_path = controller_path
        @action_name = adjusted_action_name(action_name)
        @context = context
        @include_application_name = include_application_name
      end

      def to_s
        parts = []
        parts << I18n.t(
          [:titles, controller_name, action_name].join('.'),
          context.merge(default: defaults)
        )
        parts << I18n.t(context.merge(default: defaults)) if include_application_name
        parts.uniq.join(SEPARATOR)
      end

      private

      attr_reader :controller_path, :action_name, :context, :include_application_name

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

      def adjusted_action_name(action_name)
        case action_name
        when 'create'
          'new'
        when 'update'
          'edit'
        else
          action_name
        end
      end
    end
  end
end
