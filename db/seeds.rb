require 'ffaker'

2.times do
  #today tasks complete
  Task.create!(name:FFaker::Lorem.phrase, start_date:Date.today, finish_date:Date.today, completed:true )
  #today tasks incomplete
  Task.create!(name:FFaker::Lorem.sentence, start_date:Date.today, completed:false)
  #tomorrow todo tasks
  Task.create!(name:FFaker::Lorem.sentence, start_date:Date.tomorrow, completed:false)
  #future incomplete tasks
  Task.create!(name:FFaker::Lorem.sentence, start_date:(2..10).to_a.sample.day.from_now, completed:false)
end