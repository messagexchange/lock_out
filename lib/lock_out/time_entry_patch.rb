module LockOut
  module TimeEntryPatch
    def self.included(base)
      base.class_eval do
        validate :check_date_for_lock_out
      end

      base.send(:include, InstanceMethods)
    end

    module InstanceMethods

      def check_date_for_lock_out
        unless self.spent_on.nil?
          if invalid_lock_out_date?
            errors.add :spent_on, "cannot be a previous month as that month is locked."
          end
        end
      end

      def invalid_lock_out_date?
        self.spent_on <= (Time.now - 1.month).end_of_month.to_date &&
          is_locked?
      end

      def is_locked?
        lock_out_date = LockOutDate.
          where(:month => spent_on.month, :year => spent_on.year).
          first
        return true if lock_out_date.nil?
        lock_out_date.locked
      end

    end
  end
end

TimeEntry.send(:include, LockOut::TimeEntryPatch)