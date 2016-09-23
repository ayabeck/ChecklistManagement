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

class FormItem < ActiveRecord::Base
  belongs_to :template

  validates :type,  presence: true
  validates :label, presence: true

  TYPES = %w(Heading HelpText Checkbox)

  def self.types_collection
    TYPES.each_with_object([]) do |type, object|
      object << [I18n.t("activerecord.models.form_items.#{ type.underscore }"), type]
    end
  end

  def set_parent(template)
    self.template_id = template.id
    self.order       = FormItem.where(template_id: template.id).count(:id) + 1
  end

  def type_name
    I18n.t("activerecord.models.form_items.#{ self.type.underscore }")
  end
end
