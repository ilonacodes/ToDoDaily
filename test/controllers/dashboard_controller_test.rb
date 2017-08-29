require 'test_helper'

class DashboardControllerTest < ActionDispatch::IntegrationTest
  test 'it responds with success' do
    get dashboard_url

    assert_response :success
  end

  test 'it loads all tasks' do
    get dashboard_url
    actual_tasks = assigns[:tasks].to_a

    expected_tasks = [tasks(:one), tasks(:two)]
    assert_equal(expected_tasks, actual_tasks)
  end
end
