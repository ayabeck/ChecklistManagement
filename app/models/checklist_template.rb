# == Schema Information
#
# Table name: checklist_templates
#
#  id               :integer          not null, primary key
#  title            :string           not null
#  description      :text
#  checklists_count :integer          default(0), not null
#  creator          :string           not null
#  updater          :string           not null
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#

class ChecklistTemplate < ActiveRecord::Base
  validates :title,   presence: true
  validates :creator, presence: true
  validates :updater, presence: true
end
