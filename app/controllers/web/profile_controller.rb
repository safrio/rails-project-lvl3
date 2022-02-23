# frozen_string_literal: true

module Web
  class ProfileController < ApplicationController
    def index
      authorize Bulletin
      @bulletins = current_user.bulletins.order(id: :desc).page params[:page]
    end
  end
end
