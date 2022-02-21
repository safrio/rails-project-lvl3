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
    event?(:moderate)
  end

  def archivable?
    event?(:archive)
  end

  def publishable?
    event?(:publish)
  end

  def rejectable?
    event?(:reject)
  end

  private

  def event?(event)
    aasm.permitted_transitions.select { |t| t[:event] == event }.present?
  end
end
