class Review < ApplicationRecord
	belongs_to :reviewer, foreign_key: :reviewer_id, class_name: "User"
	belongs_to :reviewee, foreign_key: :reviewee_id, class_name: "User"

	validates :rating,
		presence: true,
		numericality: { only_integer: true, greater_than: 0, less_than_or_equal_to: 5 }
	
	validates :reviewer_id,
		uniqueness: { scope: :reviewee_id },
		presence: true

	validates :reviewee_id,
		uniqueness: { scope: :reviewer_id },
		presence: true

	validate :check_reviewer_is_not_reviewee

	def check_reviewer_is_not_reviewee
		errors.add(:reviewee, "Reviewer cannot review themself") if reviewer_id == reviewee_id
	end
end
