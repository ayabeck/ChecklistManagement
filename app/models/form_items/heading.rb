# == Schema Information
#
# Table name: form_items
#
#  id          :integer          not null, primary key
#  type        :string           not null
#  order       :integer          not null
#  label       :string           not null
#  value       :string
#  template_id :integer
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

class Heading < FormItem
end
