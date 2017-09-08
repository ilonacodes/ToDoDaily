require 'test_helper'

class TasksControllerTest < ActionDispatch::IntegrationTest
  test '#create redirects to dashboard' do
    post tasks_url, params: { title: 'Read a book' }

    assert_redirected_to(dashboard_url)
  end

  test '#create creates a new task' do
    post tasks_url, params: { title: 'Read a book' }
    actual = Task.last.title

    assert_equal('Read a book', actual)
  end

  test '#create creates a new task with #tag' do
    post tasks_url, params: { title: 'Read a book #Reading' }
    actual = Task.last

    assert_equal('Read a book', actual.title)
    assert_equal('Reading', actual.tag)

  end

  test '#complete completes a task' do
    id = tasks(:one).id
    post complete_task_url(id)

    actual = Task.find(id)

    assert_equal(true, actual.completed)
  end

  test '#complete redirects to dashboard' do
    id = tasks(:one).id
    post complete_task_url(id)

    assert_redirected_to(dashboard_url)
  end

end
