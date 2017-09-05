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

  test 'it renders input field' do
    get dashboard_url

    assert_select 'form input[type=text][name=title]'
  end

  test 'it renders list of tasks' do
    get dashboard_url

    assert_select 'ul' do
      assert_select 'li', tasks(:one).title
      assert_select 'li', tasks(:two).title
    end
  end

  test 'it renders the completed task' do
    tasks(:one).update(completed: true)

    get dashboard_url

    assert_select 'ul' do
      assert_select 'li.completed', tasks(:one).title
      assert_select 'li', tasks(:two).title
    end
  end
end
