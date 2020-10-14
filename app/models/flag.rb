class Flag < ApplicationRecord
  belongs_to :game

  before_save :set_flag

  def set_flag
    case self.kind
    when nil
      self.kind = 'flag'
    when 'flag'
      self.kind = 'question'
    when 'question'
      self.kind = nil
    end
  end
end
