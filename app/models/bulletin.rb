# frozen_string_literal: true

class Bulletin < ApplicationRecord
  include AASM

  validates :title, :description, :image, presence: true
  validates :title, length: { minimum: 3 }

  belongs_to :category
  belongs_to :user
  has_one_attached :image

  aasm column: :state do
    state :draft, initial: true
    state :under_moderation, :published, :rejected, :archived

    event :moderate do
      transitions from: :draft, to: :under_moderation
    end

    event :publish do
      transitions from: :under_moderation, to: :published
    end

    event :archive do
      transitions from: %w[draft published under_moderation], to: :archived
    end

    event :reject do
      transitions from: :under_moderation, to: :rejected
    end
  end

  def moderatable?
    allowed_state?(:under_moderation)
  end

  def archivable?
    allowed_state?(:archived)
  end

  def publishable?
    allowed_state?(:published)
  end

  def rejectable?
    allowed_state?(:rejected)
  end

  private

  def allowed_state?(state)
    aasm.states(permitted: true).map(&:name).include?(state)
  end
end
