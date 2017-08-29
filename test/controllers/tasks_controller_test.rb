require 'test_helper'

class TasksControllerTest < ActionDispatch::IntegrationTest
 test 'it responds with success' do
   post tasks_url

   assert_redirected_to(dashboard_url)
 end

  test 'it creates a new task' do
    post tasks_url, params: { title: 'Read a book' }
    actual = Task.last.title

    assert_equal('Read a book', actual)
  end
end
