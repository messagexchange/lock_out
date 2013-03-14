class LockOutDate < ActiveRecord::Base
  unloadable

  def ==(other)
    self.month == other.month &&
      self.year == other.year
  end
  alias :eql? :==
end
