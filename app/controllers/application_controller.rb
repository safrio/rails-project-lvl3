# frozen_string_literal: true

class ApplicationController < ActionController::Base
  include AuthConcern
  include Pundit::Authorization

  rescue_from Pundit::NotAuthorizedError, with: :restricted_content

  def restricted_content
    redirect_to (request.referer || root_path), alert: t('restricted_content')
  end
end
