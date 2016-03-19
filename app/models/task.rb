class Task < ActiveRecord::Base

  validates :name, presence: true, :uniqueness => {:case_sensitive => false}
  validates :start_date, presence: true
  validate :start_date_cannot_be_in_the_past
  validate :not_completed_when_start_date_in_future

  scope :today_incomplete_tasks, -> { where(completed: false).where("start_date = ?", Date.today) }
  scope :today_complete_tasks, -> { where(completed: true).where("start_date = ?", Date.today) }
  scope :tomorrow_tasks, -> { where("start_date = ?", Date.tomorrow) }
  scope :later_todo_tasks, -> { where("start_date > ?", Date.tomorrow) }

  def start_date_cannot_be_in_the_past
    if !start_date.blank? && start_date < Date.today
      errors.add(:start_date, "can't be in the past")
    end
  end

  def not_completed_when_start_date_in_future
    if (start_date && start_date > Date.today && completed)
      errors.add(:completed, "can't be completed before starting")
    end
  end

  def update_status
    complete? ? update(completed: true) : update(completed: false)
  end

  def the_past?
    start_date < Date.today
  end

  def self.search(search_term, page)
    return Task.order(:name).page(page) if search_term.blank?
    name, description = "%#{search_term.downcase}%", "%#{search_term.downcase}%"
    Task.where('(lower(name) like ?) or (lower(description) like ?)',
               name, description).order(:name, :description).page(page)
  end
end