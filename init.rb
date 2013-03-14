require 'lock_out/time_entry_patch'

Redmine::Plugin.register :lock_out do
  name 'Lock Out'
  author 'Paul Van de Vreede'
  description 'Redmine Plugin that locks timesheet entry for the previous month unless allowed by admin.'
  version '0.9.0'
  url 'https://github.com/messagexchange/lock_out'
  author_url 'https://github.com/pvdvreede'
end