# == Schema Information
#
# Table name: templates
#
#  id               :integer          not null, primary key
#  title            :string           not null
#  description      :text
#  checklists_count :integer          default(0), not null
#  creator          :string           not null
#  updater          :string           not null
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#

class Template < ActiveRecord::Base
  has_many :checklists

  validates :title,   presence: true
  validates :creator, presence: true
  validates :updater, presence: true
end
