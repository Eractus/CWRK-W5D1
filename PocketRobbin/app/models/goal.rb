# == Schema Information
#
# Table name: goals
#
#  id         :integer          not null, primary key
#  user_id    :integer          not null
#  objective  :string           not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Goal < ApplicationRecord
  validates :user_id, :objective, presence: true

  belongs_to :user,
    class_name: :User,
    foreign_key: :user_id
end
