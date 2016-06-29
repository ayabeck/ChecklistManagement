# == Schema Information
#
# Table name: checklists
#
#  id         :integer          not null, primary key
#  title      :string
#  checker    :string
#  start_at   :datetime
#  due_at     :datetime
#  submitter  :string
#  submit_at  :datetime
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Checklist < ActiveRecord::Base
end
