require 'test_helper'

class ProjectTest < ActiveSupport::TestCase
  test "should be able to retrieve projects based on day" do
    actual = projects(:gradschoolmatch).reports_grouped_by_day
    expected_keys = actual.keys.sort.map{|d| d.to_s(:db)}
    assert_equal ["2011-07-01", "2011-07-05"], expected_keys
    assert_equal [status_reports(:first).id], actual[Date.parse("2011-07-01")].map(&:id)
    assert_equal [status_reports(:second).id], actual[Date.parse("2011-07-05")].map(&:id)
  end
end
