class Contact < ActiveRecord::Base

	def is_answered?
		self.answer.present?
	end

end
