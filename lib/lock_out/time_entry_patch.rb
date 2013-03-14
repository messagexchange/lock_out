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
        require 'debugger'; debugger
        current_date = Time.now
        entry_date = self.spent_on
        if current_date.month > entry_date.month
          errors.add :spent_on, "cannot be a previous month as that month is locked."
        end
      end

    end
  end
end

TimeEntry.send(:include, LockOut::TimeEntryPatch)