require 'application_system_test_case'

class RenderAllDaysTest < ApplicationSystemTestCase
  test 'it renders all days page' do
    Task.create(title: 'greet world', created_at: 10.days.ago)
    Task.create(title: 'greet world', created_at: 1.year.ago)
    Task.create(title: 'greet world', created_at: 370.days.ago)

    visit dashboard_url

    click_link('All Days')

    [Date.today, 10.days.ago, 1.year.ago].each do |day|
      assert_selector(".previous-day a", text: day.strftime('%d-%m-%Y'))
    end

    [1.day.ago, 2.days.ago, 3.month.ago].each do |day|
      refute_selector(".previous-day a", text: day.strftime('%d-%m-%Y'))
    end
  end
end