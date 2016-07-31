# == Schema Information
#
# Table name: checklists
#
#  id                    :integer          not null, primary key
#  title                 :string           not null
#  checker               :string
#  start_at              :datetime
#  due_at                :datetime
#  submitter             :string
#  submit_at             :datetime
#  checklist_template_id :integer
#  created_at            :datetime         not null
#  updated_at            :datetime         not null
#

class Checklist < ActiveRecord::Base
  belongs_to :checklist_template, counter_cache: true

  validates :title, presence: true
end
