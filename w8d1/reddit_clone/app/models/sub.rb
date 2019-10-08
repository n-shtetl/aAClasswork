# == Schema Information
#
# Table name: subs
#
#  id          :bigint           not null, primary key
#  title       :string
#  description :string
#  user_id     :integer
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

class Sub < ApplicationRecord
  validates :title, :user_id, presence: true

  belongs_to :user

  has_many :post_subs, dependent: :destroy, inverse_of: :sub 
  has_many :posts, through: :post_subs
  
end
