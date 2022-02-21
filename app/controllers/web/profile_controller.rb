# frozen_string_literal: true

module Web
  class ProfileController < ApplicationController
    before_action :authenticate_user!

    def index
      @bulletins = current_user.bulletins.order(id: :desc)
    end
  end
end
