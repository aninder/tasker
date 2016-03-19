require 'rails_helper'

RSpec.describe Task, type: :model do

  it {should validate_presence_of :name}
  it {should validate_presence_of :start_date}

  let(:task) { FactoryGirl.build(:task, name: "xxx", start_date: Date.today) }

  it "is valid" do
    expect(task).to be_valid
  end

  it "is invalid with a start date earlier than the current date" do
    task.start_date = 1.day.ago
    expect(task).to_not be_valid
    expect(task.errors.messages[:start_date][0]).to eq("can't be in the past")
  end

  it "is invalid with start date in the future and completed set as true" do
    task.start_date = 2.day.from_now
    task.completed = true

    expect(task).to_not be_valid
    expect(task.errors.messages[:completed][0]).to eq("can't be completed before starting")
  end

  describe "#today todo tasks" do
    context "with no tasks for today" do
      it "should return null" do
        expect(Task.today_incomplete_tasks.size).to eq 0
      end
    end

    context "with some incomplete to do tasks" do
      it "returns incomplete todo tasks for today" do
        FactoryGirl.create(:task, start_date: Date.today, completed:false)
        FactoryGirl.create(:task, start_date: Date.today, completed:false)
        FactoryGirl.create(:task, start_date: Date.today, completed:true)
        FactoryGirl.create(:task, start_date: Date.today, completed:true)
        FactoryGirl.create(:task, start_date: Date.tomorrow, completed:false)
        FactoryGirl.create(:task, start_date: Date.tomorrow, completed:false)

        expect(Task.today_incomplete_tasks.size).to eq 2
      end
    end
  end

  describe "#today completed tasks" do
    context "with no completed tasks for today" do
      it "should return null" do
        expect(Task.today_complete_tasks.size).to eq 0
      end
    end

    context "with some to do tasks  today" do
      it "returns incomplete todo tasks for today" do
        FactoryGirl.create(:task, start_date: Date.today, completed:false)
        FactoryGirl.create(:task, start_date: Date.today, completed:false)
        FactoryGirl.create(:task, start_date: Date.today, completed:true)
        FactoryGirl.create(:task, start_date: Date.tomorrow, completed:false)
        FactoryGirl.create(:task, start_date: Date.tomorrow, completed:false)

        expect(Task.today_complete_tasks.size).to eq 1
      end
    end
  end

  describe "#tomorrow tasks" do
    it "returns incomplete todo tasks for today" do
      FactoryGirl.create(:task, start_date: Date.today, completed:false)
      FactoryGirl.create(:task, start_date: Date.today, completed:true)
      FactoryGirl.create(:task, start_date: Date.tomorrow, completed:false)
      FactoryGirl.create(:task, start_date: 3.day.from_now, completed:false)
      FactoryGirl.create(:task, start_date: 23.day.from_now, completed:false)

      expect(Task.tomorrow_tasks.size).to eq 1
    end
  end

  describe "tasks on a later date" do
    context "with no completed tasks for today" do
      it "should return null" do
        expect(Task.later_todo_tasks.size).to eq 0
      end
    end

    context "with some to do tasks today" do
      it "returns incomplete todo tasks for today" do
        FactoryGirl.create(:task, start_date: Date.today, completed:false)
        FactoryGirl.create(:task, start_date: Date.today, completed:true)
        FactoryGirl.create(:task, start_date: Date.tomorrow, completed:false)
        FactoryGirl.create(:task, start_date: 3.day.from_now, completed:false)
        FactoryGirl.create(:task, start_date: 23.day.from_now, completed:false)
        FactoryGirl.create(:task, start_date: 12.day.from_now, completed:false)

        expect(Task.later_todo_tasks.size).to eq 3
      end
    end
  end
end
