class User < ActiveRecord::Base
	has_many :publications
	belongs_to :research_field

	has_secure_password 

	def research_field_name
		if self.research_field_id
		ResearchField.find(self.research_field_id).name 
		else
			"no type selected"
		end
	end

end