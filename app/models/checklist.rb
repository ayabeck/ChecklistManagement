# == Schema Information
#
# Table name: checklists
#
#  id          :integer          not null, primary key
#  title       :string           not null
#  checker     :string
#  start_at    :datetime
#  due_at      :datetime
#  submitter   :string
#  submit_at   :datetime
#  template_id :integer
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

class Checklist < ActiveRecord::Base
  belongs_to :template, counter_cache: true
  has_many :form_items

  validates :title, presence: true

  def forms
    self.form_items.each_with_object([]) do |item, object|
      object << item if item.is_form?
    end
  end

  def update_forms!(form_params)
    if form_params
      self.forms.each do |form|
        new_value = form_params[form.id.to_s]
        form.update_value!(new_value)
      end
    else
      self.forms.each do |form|
        new_value = ''
        form.update_value!(new_value)
      end
    end
  end
end
