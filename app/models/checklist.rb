# == Schema Information
#
# Table name: checklists
#
#  id               :integer          not null, primary key
#  title            :string           not null
#  checker          :string
#  start_at         :datetime
#  due_at           :datetime
#  progression_rate :integer          default(0), not null
#  submitter        :string
#  submit_at        :datetime
#  template_id      :integer
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
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
    completed_forms_num = 0
    form_params ||= {}
    self.forms.each do |form|
      new_value = form_params.fetch(form.id.to_s, '')
      form.update_value!(new_value)
      completed_forms_num += 1 if new_value.present?
    end

    self.update!(progression_rate: (completed_forms_num.quo(self.forms.size) * 100).round)
  end
end
