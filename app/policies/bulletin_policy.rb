# frozen_string_literal: true

class BulletinPolicy < ApplicationPolicy
  def index?
    signed_in?
  end

  def new?
    signed_in?
  end

  def create?
    signed_in?
  end

  def edit?
    author? || admin?
  end

  def update?
    author? || admin?
  end

  def archive?
    author? || admin?
  end

  def moderate?
    author? || admin?
  end

  def on_moderation?
    admin?
  end

  def reject?
    admin?
  end

  def publish?
    admin?
  end
end
