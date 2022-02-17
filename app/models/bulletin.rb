# frozen_string_literal: true

class Bulletin < ApplicationRecord
  validates :title, :description, :image, presence: true
  validates :title, length: { minimum: 3 }

  belongs_to :category
  belongs_to :user
  has_one_attached :image
end
