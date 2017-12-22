Rails.application.config.active_record.belongs_to_required_by_default = false

class Post < ApplicationRecord
  enum status: { submitted: 0, approved: 1, rejected: 2 }
  belongs_to :user
  validates_presence_of :date, :rationale
end