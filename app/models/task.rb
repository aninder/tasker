class Task < ActiveRecord::Base

  validates :name, presence: true, :uniqueness => { :case_sensitive => false }
  validates :start_date, presence: true
  validate :start_date_cannot_be_in_the_past

  scope :current, -> { where(completed: false).where("start_date <= ?", Date.today) }
  scope :complete, -> { where(completed: true) }
  scope :future, -> { where(completed: false).where("start_date > ?", Date.today) }

  def start_date_cannot_be_in_the_past
    errors.add(:start_date, "can't be in the past") if !start_date.blank? && start_date < Date.today
  end

  def update_status
    if complete?
      update(completed: true)
    else
      update(completed: false)
    end
  end

  def the_past?
    true if self.start_date.present? && self.start_date <= Date.today
  end

  def self.search(search_term, page)
    return Task.order(:name).page(page) if search_term.blank?
    name, description = "%#{search_term.downcase}%", "%#{search_term.downcase}%"
    Task.where('(lower(name) like ?) or (lower(description) like ?)',
               name, description).order(:name, :description).page(page)
  end
end
