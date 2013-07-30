module BootstrapHelper

	def dropdown_link( text )
		return "
<a class='dropdown-toggle' href='\#' data-toggle='dropdown'>
	#{text} <strong class='caret'></strong>
</a>".html_safe
	end
end
