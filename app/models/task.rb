class Task < ApplicationRecord
  belongs_to :user
  
  # 存在性の検証
  validates :task_name, presence: true, length: { maximum: 20 }
  validates :note, presence: true, length:{ maximum: 100 }
end
