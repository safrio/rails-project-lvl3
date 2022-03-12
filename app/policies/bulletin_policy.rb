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
    author?
  end

  def update?
    author?
  end

  def archive?
    author?
  end

  def moderate?
    author?
  end
end
