require 'test_helper'

class StatusReportTest < ActiveSupport::TestCase
  test "saving a status report should save the status date" do
    actual = StatusReport.new(:today => "t", :yesterday => "y")
    actual.save
    assert_equal Date.today.to_s(:db) , actual.status_date.to_s(:db)
  end

  test "saving a status report that has a status date already doesn't override previous date" do
    actual = StatusReport.new(:status_date => 10.days.ago.to_date, :today => "t", :yesterday => "y")
    actual.save
    actual.reload
    assert_equal 10.days.ago.to_date.to_s(:db) , actual.status_date.to_s(:db)
  end

  test "a report with Yesterday's status and today's status blank is not valid" do
    actual = StatusReport.new(:today => "", :yesterday => "")
    assert !actual.valid?
  end

  test "a report with yesterday blank is valid" do
    actual = StatusReport.new(:today => "", :yesterday => "y")
    assert actual.valid?
  end

  test "a report with today blank is valid" do
    actual = StatusReport.new(:today => "t", :yesterday => "")
    assert actual.valid?
  end
end
