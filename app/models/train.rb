class Train < ApplicationRecord
  belongs_to :user

  def rm
    self.weight * (1 + self.rep / 40.0)
  end
end
