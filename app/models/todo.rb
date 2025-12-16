class Todo < ApplicationRecord
  validates :title, presence: true

  # completedがnilの場合はfalseとして扱う
  after_initialize :set_default_completed, if: :new_record?

  private

  def set_default_completed
    self.completed ||= false
  end
end
