module Title
  module TitleHelper
    def title
      PageTitle.new(controller_path, action_name, controller.view_assigns.symbolize_keys).to_s
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
          context.merge(default: [application_title, guess_title])
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

      def controller_name
        controller_path.gsub('/', '.')
      end
    end
  end
end
