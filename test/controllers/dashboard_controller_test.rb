require 'test_helper'

class DashboardControllerTest < ActionDispatch::IntegrationTest
  test 'it responds with success' do
    get dashboard_url

    assert_response :success
  end

  test 'it loads all tasks' do
    get dashboard_url
    actual_tasks = assigns[:tasks].to_a

    expected_tasks = [tasks(:one), tasks(:two), tasks(:three), tasks(:four), tasks(:five), tasks(:six)]
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

  test 'it categorizes tasks by tag' do
    get dashboard_url

    assert_select 'ul.programming' do
      assert_select 'li', tasks(:one).title
      assert_select 'li', 1
    end

    assert_select 'ul.reading' do
      assert_select 'li', tasks(:two).title
      assert_select 'li', 1
    end

    assert_select 'ul.sport' do
      assert_select 'li', tasks(:three).title
      assert_select 'li', 1
    end

    assert_select 'ul.languages' do
      assert_select 'li', tasks(:four).title
      assert_select 'li', 1
    end

    assert_select 'ul.university' do
      assert_select 'li', tasks(:five).title
      assert_select 'li', 1
    end

    assert_select 'ul.daily-routine' do
      assert_select 'li', tasks(:six).title
      assert_select 'li', 1
    end
  end

  test 'it renders the completed task' do
    tasks(:one).update(completed: true)

    get dashboard_url

    assert_select 'ul' do
      assert_select 'li.completed a', tasks(:one).title
      assert_select 'li.completed .checkbox', '✓'
      assert_select 'li', tasks(:two).title
    end
  end
end
