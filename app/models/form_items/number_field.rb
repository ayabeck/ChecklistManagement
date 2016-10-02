# == Schema Information
#
# Table name: form_items
#
#  id           :integer          not null, primary key
#  type         :string           not null
#  order        :integer          not null
#  label        :string           not null
#  value        :string
#  template_id  :integer
#  checklist_id :integer
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#

class NumberField < FormItem
  validates :value, numericality: true

  def is_form?
    true
  end

  private
    def DEFAULT_VALUE
      ''
    end
end
