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

class FormItem < ActiveRecord::Base
  belongs_to :template
  belongs_to :checklist

  validates :type,  presence: true
  validates :label, presence: true

  before_create :set_default

  FORM_TYPES = %w(Checkbox NumberField Textarea)
  TYPES = FORM_TYPES.concat %w(Heading HelpText)
  def DEFAULT_VALUE
    nil
  end

  default_scope { order(:order) }
  scope :completed, -> { where.not(value: [nil, '']) }
  scope :extract_forms, -> { where(type: FORM_TYPES) }

  def initialize(*)
    super
    self.order = FormItem.where(template_id: self.template_id).count(:id)
  end

  # parent は Template と Checklist のみを想定
  def self.batch_copy(from_parent, to_parent)
    from_parent.form_items.each do |item|
      new_item = item.dup
      if to_parent.kind_of?(Template)
        new_item.template_id  = to_parent.id
        new_item.checklist_id = nil
      else
        new_item.template_id  = nil
        new_item.checklist_id = to_parent.id
      end

      to_parent.form_items << new_item
    end
  end

  def self.types_collection
    TYPES.each_with_object([]) do |type, object|
      object << [I18n.t("activerecord.models.form_items.#{ type.underscore }"), type]
    end
  end

  def type_name
    I18n.t("activerecord.models.form_items.#{ self.type.underscore }")
  end

  private
    def set_default
      self.value = DEFAULT_VALUE()
    end
end
