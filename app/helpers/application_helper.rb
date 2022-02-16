# frozen_string_literal: true

module ApplicationHelper
  def nav_menu_item(name, path = '#', options = {})
    assembled_options = options.merge(class: "nav-link link-dark #{active?(path)}")
    tag.li class: 'nav-item' do
      link_to path, assembled_options do
        tag.div(name)
      end
    end
  end

  def active?(path, options = {})
    # raise options.inspect
    if options.key? :active_if
      'active' if options[:active_if]
    elsif current_page?(path)
      'active'
    end
  end

  def signed_in?
    !!current_user
  end

  def current_user
    @current_user ||= User.find_by(id: session[:user_id])
  end
end
