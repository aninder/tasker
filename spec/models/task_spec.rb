require 'rails_helper'

RSpec.describe Task, type: :model do

  it {should validate_presence_of :name}
  it {should validate_presence_of :start_date}

  let(:task) { Task.new(name: "xxx", start_date: Date.current) }

  it "is valid" do
    expect(task).to be_valid
  end

  it "is invalid with a start date earlier than the current date" do
    task.start_date = Date.current.prev_day
    expect(task).to_not be_valid
    expect(task.errors.messages[:start_date][0]).to eq("can't be in the past")
  end

end
