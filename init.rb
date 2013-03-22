require 'lock_out/time_entry_patch'

Redmine::Plugin.register :lock_out do
  name 'Lock Out'
  author 'Paul Van de Vreede'
  description 'Redmine Plugin that locks timesheet entries for the previous month unless allowed by admin.'
  version '0.9.0'
  url 'https://github.com/messagexchange/lock_out'
  author_url 'https://github.com/pvdvreede'

  permission :view_lock_dates, { :lock_out => :index }
  permission :alter_lock_dates, { :lock_out => [:lock, :unlock] }

  # settings for what day of the month the lockout occurs
  settings :partial => 'lock_out_settings',
           :default => { 'lock_out_day' => 1 }

  menu :top_menu, :lock_out, { :controller => 'lock_out', :action => 'index' }, :caption => "Lock out dates", :if => Proc.new { User.current.allowed_to?({ :controller => 'lock_out', :action => 'index' }, nil, :global => true) }
end
