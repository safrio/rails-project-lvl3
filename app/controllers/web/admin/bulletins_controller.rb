# frozen_string_literal: true

module Web
  module Admin
    class BulletinsController < AdminController
      before_action :set_bulletin, only: %i[publish reject]

      def index
        @bulletins = Bulletin.order(id: :desc)
      end

      def on_moderation
        @bulletins = Bulletin.under_moderation.order(id: :desc)
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

      def set_bulletin
        @bulletin = Bulletin.find(params[:id])
      end
    end
  end
end
