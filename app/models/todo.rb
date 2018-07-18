class Todo < ApplicationRecord
  validates :title, presence: true

  def title
    super || 'default title'
  end
end
