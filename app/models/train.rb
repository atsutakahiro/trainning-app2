class Train < ApplicationRecord
  belongs_to :user

  
  validates :rep, presence: true, if: -> { rep_changed? }
  PARTS = ["胸", "肩", "上腕二頭筋", "上腕三頭筋", "腹筋", "背中", "脚"]
  # 略

  validates :rep, presence: true


  def rm
    return nil unless self.weight && self.rep
    self.weight * (1 + self.rep / 40.0)
  end
end
