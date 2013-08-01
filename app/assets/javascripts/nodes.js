/* Handles behavior of the bulleted list of
 * branches
 *
 * Gon variables set:
 * gon.runEditBranch : causes branchSetup to run
 * gon.nodes         : hash of node id's to @tree.nodes
 * gon.rootId        : id of root node
 * gon.updatePath    : path to update node text
 */

function branchSetup() {

	branchRefresh();

	var $list = $( "#branchEditList" );
	$list.on( 'click', 'span.node', branchToInput );
	$list.on( 'blur', 'input.node', nodeUpdate );
}

function buildSpanBranch( node ) {
	var $span = $("<span class='node'></span>");
	var txt = $.trim( node.text );
	txt = ( txt == '' ) ? "Click to Edit" : txt;
	$span.html( txt ).attr( "id", node.id );
	return $span;
}

function buildInputBranch( node ) {
	var $input = $("<input type='text' class='node'>");
	var txt = $.trim( node.text );
	$input.val( txt ).attr( "id", node.id );
	return $input;
}

function branchToInput() {
	var $this = $(this);
	var node = gon.nodes[ $this.attr("id") ];
	var $input = buildInputBranch( node );

	$this.replaceWith( $input );
	$input.select();
}

function nodeUpdate() {
	var $this = $(this);
	var node = gon.nodes[ $this.attr("id") ];
	var txt = $(  )
	if ( $this.val() == 
}
/*
function branchFromInput() {
	var $this = $(this);

	var $span = $("<span class='node'></span>");
	$span.html( $this.val() );
	$span.attr( "id", $this.attr('id') );
	$this.replaceWith( $span );

	branchRefresh();
}*/

function branchRefresh() {
	var $list = $( "#branchEditList" );
	$list.empty();

	function build( node ) {
		$line = $( "<li></li>" );
		$line.html( buildSpanBranch( node ) );
		return $line;
	}

	var topNodes = findChildren( gon.nodes[ gon.rootId ] );
	for ( var i = 0; i<topNodes.length; i++ ) {
		$list.append( build( topNodes[i] ) );
	}
}

//Returns children of this node
function findChildren( node ) {
	var a = [];
	for ( var k in gon.nodes ) {
		if ( gon.nodes[k].parent_id == node.id ) {
			a.push( gon.nodes[k] )
		}
	}
	return a;
}



