# == Schema Information
#
# Table name: checklist_templates
#
#  id               :integer          not null, primary key
#  title            :string
#  description      :text
#  checklists_count :integer
#  creator          :string
#  updater          :string
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#

class ChecklistTemplate < ActiveRecord::Base
end
