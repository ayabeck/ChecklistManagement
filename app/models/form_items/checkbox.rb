# == Schema Information
#
# Table name: form_items
#
#  id         :integer          not null, primary key
#  type       :string
#  order      :integer
#  label      :string
#  value      :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Checkbox < FormItem
end
