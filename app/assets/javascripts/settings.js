$(function() {
	$('.fileSel').change(function(){
		var MAXWIDTH = 100;
		var MAXHEIGHT = 100;
		var files = $(".fileSel")[0].files;
		if(files){
			for(var i = 0; i < files.length; i++) {
				var file = files[i];
				var imageType = /image.*/;

				if(!file.type.match(imageType)) {
					continue;
				}
				var reader = new FileReader();
				reader.readAsDataURL(file);
				reader.onload = function(e) {
					var imgObj = new Image();
					imgObj.src = this.result;
					imgObj.onload = function(event) {
					 	$("#imgread").attr("src", imgObj.src).width(MAXWIDTH).height(MAXHEIGHT)
					}
				}
			}
		}
		else{
			var file = $(".fileSel");
			file.select();
			file.blur();
			var src = document.selection.createRange().text;
			$(".imgread").hide();
			var img = $("#preview")[0];
			img.filter.item('DXImageTransform.Microsoft.AlphaImageLoader').src = src;
			document.selection.empty();
		}
	})

})