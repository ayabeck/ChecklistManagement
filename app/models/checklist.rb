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
  has_many :form_items, dependent: :destroy

  validates :title, presence: true
  validate  :validate_start_at

  def init(parent)
    self.title    = parent.title if parent.kind_of?(Template)
    self.start_at = DateTime.now.beginning_of_hour + 1.hour
    self.due_at   = self.start_at + 1.hour
  end

  def forms
    self.form_items.extract_forms
  end

  def form_items_adding(form_params)
    form_params ||= {}
    self.form_items.each_with_object([]) do |item, object|
      item.value = form_params.fetch(item.id.to_s, item.DEFAULT_VALUE())
      object << item
    end
  end

  def withdraw!
    self.update!(
        submitter: nil,
        submit_at: nil
    )
  end

  def submitted!(submitter = nil)
    self.update!(
        submitter: submitter,
        submit_at: DateTime.current
    )
  end

  def update_progression_rate!
    self.update!(
        progression_rate: (self.forms.completed.count.quo(self.forms.size) * 100).round
    )
  end

  private
    def validate_start_at
      if self.start_at && self.due_at
        errors.add(:start_at, :validate_start_at) unless (self.start_at < self.due_at)
      end
    end
end
