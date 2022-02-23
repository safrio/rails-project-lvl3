# frozen_string_literal: true

module Web
  module Admin
    class BulletinsController < AdminController
      before_action :set_bulletin, only: %i[publish reject]
      before_action :authorize!

      def index
        @q = Bulletin.published.ransack(params[:q])
        @bulletins = @q.result.order(id: :desc).page params[:page]
      end

      def on_moderation
        @bulletins = Bulletin.under_moderation.order(id: :desc).page params[:page]
      end

      def publish
        @bulletin.publish!

        redirect_to admin_bulletins_url, notice: 'Bulletin was successfully published.'
      end

      def reject
        @bulletin.reject!

        redirect_to admin_bulletins_url, notice: 'Bulletin was successfully rejected.'
      end

      private

      def authorize!
        authorize Bulletin
      end

      def set_bulletin
        @bulletin = Bulletin.find(params[:id])
        authorize @bulletin
      end
    end
  end
end
