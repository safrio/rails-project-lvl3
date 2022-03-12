# frozen_string_literal: true

module Web
  module Admin
    class AdminController < ApplicationController
      layout 'admin'

      before_action :authorize_admin!

      def authorize_admin!
        restricted_content unless admin?
      end
    end
  end
end
