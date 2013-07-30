module ApplicationHelper
	include BootstrapHelper

	def full_title( page_title )
		base_title = "Base Title"
		if page_title.empty?
			base_title
		else
			"#{base_title} | #{page_title}"
		end
	end

	def as_date( date )
		date.strftime("%-b %-d, %Y")
	end


end
