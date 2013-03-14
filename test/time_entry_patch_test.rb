require File.dirname(File.expand_path(__FILE__)) + '/./test_helper'

class TimeEntryPatchTest < ActionController::TestCase
  fixtures :users, :projects, :issues, :enumerations

  def setup
    @user = User.first
    @issue = Issue.first
    @activity = TimeEntryActivity.first
    @time_entry = TimeEntry.new(
      :issue => @issue,
      :hours => 1,
      :user => @user,
      :project => @issue.project,
      :activity => @activity
    )
  end

  def test_spent_on_is_last_month
    @time_entry.spent_on = Time.now - 1.month
    assert_equal false, @time_entry.save
    assert_equal 1, @time_entry.errors[:spent_on].count
    assert_equal "cannot be a previous month as that month is locked.", @time_entry.errors[:spent_on].first
  end

  def test_spent_on_is_last_day_of_month
    @time_entry.spent_on = (Time.now - 1.month).end_of_month
    assert_equal false, @time_entry.save
    assert_equal 1, @time_entry.errors[:spent_on].count
    assert_equal "cannot be a previous month as that month is locked.", @time_entry.errors[:spent_on].first
  end

  def test_spent_on_is_nil
    assert_equal false, @time_entry.save
    assert_equal 1, @time_entry.errors[:spent_on].count
    assert_equal "can't be blank", @time_entry.errors[:spent_on].first
  end

  def test_spent_on_is_this_month
    @time_entry.spent_on = Time.now
    assert_equal true, @time_entry.save
  end

  def test_spent_on_is_next_month
    @time_entry.spent_on = Time.now + 1.month
    assert_equal true, @time_entry.save
  end

  def test_spent_on_is_next_month_next_year
    @time_entry.spent_on = (Time.now + 1.month) + 1.year
    assert_equal true, @time_entry.save
  end

  def test_spent_on_is_last_month_next_year
    @time_entry.spent_on = (Time.now - 1.month) + 1.year
    assert_equal true, @time_entry.save
  end

  def test_spent_on_is_next_month_last_year
    @time_entry.spent_on = (Time.now + 1.month) - 1.year
    assert_equal false, @time_entry.save
    assert_equal 1, @time_entry.errors[:spent_on].count
    assert_equal "cannot be a previous month as that month is locked.", @time_entry.errors[:spent_on].first
  end

end