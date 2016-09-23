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

class FormItem < ActiveRecord::Base
  belongs_to :template
  belongs_to :checklist

  validates :type,  presence: true
  validates :label, presence: true

  TYPES = %w(Heading HelpText Checkbox)

  # parent は Template と Checklist のみを想定
  def self.batch_copy(from_parent, to_parent)
    from_parent.form_items.each do |form_item|
      new_form_item = form_item.dup
      to_parent.form_items << new_form_item
    end

    if to_parent.kind_of?(Template)
      to_parent.form_items.each do |form_item|
        form_item.template_id  = to_parent.id
        form_item.checklist_id = nil
      end
    elsif to_parent.kind_of?(Checklist)
      to_parent.form_items.each do |form_item|
        form_item.template_id  = nil
        form_item.checklist_id = to_parent.id
      end
    end
  end

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
