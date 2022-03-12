# frozen_string_literal: true

module Web
  module Admin
    class BulletinsController < AdminController
      before_action :set_bulletin, only: %i[archive publish reject]

      def index
        @q = Bulletin.ransack(params[:q])
        @bulletins = @q.result.order(id: :desc).page params[:page]
      end

      def on_moderation
        @bulletins = Bulletin.under_moderation.order(id: :desc).page params[:page]
      end

      def archive
        @bulletin.archive!

        redirect_to admin_bulletins_url, notice: t('.bulletin_archived')
      end

      def publish
        @bulletin.publish!

        redirect_to admin_bulletins_url, notice: t('.bulletin_published')
      end

      def reject
        @bulletin.reject!

        redirect_to admin_bulletins_url, notice: t('.bulletin_rejected')
      end

      private

      def set_bulletin
        @bulletin = Bulletin.find(params[:id])
      end
    end
  end
end
