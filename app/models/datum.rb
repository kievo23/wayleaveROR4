class Datum < ActiveRecord::Base
	validates_presence_of :permit_no , message: "Cannot be blank"
	validates_presence_of  :carriageway , message: "Cannot be blank"
	validates_presence_of  :footpath , message: "Cannot be blank"
	validates_presence_of  :verge , message: "Cannot be blank"
	validates_presence_of  :amount_paid , message: "Cannot be blank"
	validates_presence_of  :date_paid , message: "Cannot be blank"
	validates_presence_of  :Remarks , message: "Cannot be blank"
	validates_presence_of  :permit , message: "Cannot be blank"
	validates_presence_of  :wayleave_file , message: "Cannot be blank"
	def self.search(search)
	  where("permit_no LIKE ?", "%#{search}%")
	  where("route LIKE ?", "%#{search}%")
	end
end
