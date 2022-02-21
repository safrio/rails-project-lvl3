# frozen_string_literal: true

module Web
  module Admin
    class AdminController < ApplicationController
      before_action :authenticate_admin!
      layout 'admin'
    end
  end
end
