module TreesHelper
=begin
	def build_branches( tree )
		str = "<ul id='branchEditList'>"
		tree.root.children.each do |node|
			build_branches_r( node, str )
		end
		str << "<li>"
		str << render( "add_branch", parent: tree.root )
		str << "</li>"
		str << "</ul>"
		return str.html_safe
	end

	def build_branches_r( node, str )
		str << "<li>"
		str << "<span class='node' id='node#{node.id}'>"
		str << ( node.text.strip.empty? ? "Click to edit" : node.text )
		str << "</span>"
		if node.children.any?
			str << "<ul>"
			node.children.each do |c|
				build_branches_r( c, str )
			end
			str << "</ul>"
		end
		str << "</li>"
	end
=end

end
