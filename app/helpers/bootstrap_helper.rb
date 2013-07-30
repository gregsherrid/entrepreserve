module BootstrapHelper

	def dropdown_link( text )
		return "
<a class='dropdown-toggle' href='\#' data-toggle='dropdown'>
	#{text} <strong class='caret'></strong>
</a>".html_safe
	end

	def tooltip_label( base, t_text )

		split = base.index("</label>")
		return ( base[0...split] + tooltip(t_text) + base[split..-1] ).html_safe

#		return "
#<label for='#{label}'>
	#{label.to_s.capitalize.gsub(/_/, ' ')}
	#{tooltip(t_text)}
#</label>".html_safe
	end

	def tooltip( text, display=nil )
		if display.nil?
			display = "<i class='icon-question-sign'></i>"
		end
		return "
<a href='#' rel='tooltip' data-toggle='tooltip' 
			title='#{text}' class='tooltipIcon'>
	#{display}
</a>".html_safe
	end
end
