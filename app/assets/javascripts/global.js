$(document).ready(onLoad);
$(document).on('page:load', onLoad);

function onLoad() {
	$("div#javascriptWarning").remove();

	$('[rel=tooltip]').tooltip();

	if ( gon.runEditBranch ) {
		branchSetup();
	}
}