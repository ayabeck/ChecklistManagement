# == Schema Information
#
# Table name: form_items
#
#  id           :integer          not null, primary key
#  type         :string           not null
#  order        :integer          not null
#  label        :text             not null
#  value        :text
#  template_id  :integer
#  checklist_id :integer
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#

class Heading < FormItem
end
