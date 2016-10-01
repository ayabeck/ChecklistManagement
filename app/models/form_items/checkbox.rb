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

class Checkbox < FormItem
  before_create :default_value

  def checked?
    self.value == 'true'
  end

  def is_form?
    true
  end

  def update_value!(value)
    new_value = value.presence || 'false'
    self.update!(value: new_value)
  end

  private
    def default_value
      self.value = 'false'
    end
end
