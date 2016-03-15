require 'rails_helper'

RSpec.describe "tasks/index", type: :view do
  before(:each) do
    assign(:tasks, [
      Task.create!(
        :name => "Name",
        :start_date => Date.current,
        :completed => false
      ),
      Task.create!(
        :name => "Name2",
        :start_date => Date.current,
        :completed => false
      )
    ])
  end

  it "renders a list of tasks" do
    render
    assert_select "tr>td", :text => "Name".to_s, :count => 1
    assert_select "tr>td", :text => "Name2".to_s, :count => 1
    assert_select "tr>td", :text => false.to_s, :count => 2
  end
end
