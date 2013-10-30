$(function() {
	$(".image-pop").each(function(){
		$(this).click(function(){
			if($(this).children().first().attr("src")!="")
					$(".img-show").attr("src",$(this).children().first().attr("src"))
					$("#myModalLabel").html($(this).data("content"))
		})
	})
	$(".dismiss").click(function(){
		$(".image-upload").hide();
		$(".dismiss").hide();
		$('.fileSel').val("");
		$("#imgread").attr("src", "")
	})
	
	$(".accordion-toggle").each(function(){
		var image_container = $("#image-"+$(this).data("id"))
		if (image_container.children().first().children().first().attr("src")!=""){
			$(this).children().first().attr("class","icon-picture");
			$(this).click(function(e){
					 	if(image_container.is(":hidden"))
							image_container.fadeIn("slow");
						else
							image_container.hide();
			})
		}
	})

	function clacImgZoomParam( maxWidth, maxHeight, width, height ){  
        var param = {top:0, left:0, width:width, height:height};  
        if( width>maxWidth || height>maxHeight )  
        {  
            rateWidth = width / maxWidth;  
            rateHeight = height / maxHeight;  
              
            if( rateWidth > rateHeight )  
            {  
                param.width =  maxWidth;  
                param.height = Math.round(height / rateWidth);  
            }else  
            {  
                param.width = Math.round(width / rateHeight);  
                param.height = maxHeight;  
            }  
        }  
          
        param.left = Math.round((maxWidth - param.width) / 2);  
        param.top = Math.round((maxHeight - param.height) / 2);  
        return param;  
    }           

	$('.fileSel').change(function(){
		var MAXWIDTH = 200;
		var MAXHEIGHT = 150;
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
						var rect = clacImgZoomParam(MAXWIDTH, MAXHEIGHT, this.width, this.height);
                      	this.width = rect.width;
                      	this.height = rect.height;
                      	$(".image-upload").width(this.width).height(this.height)
					 	$("#imgread").attr("src", imgObj.src).width(this.width).height(this.height)
						$(".image-upload").show();
						$(".dismiss").show();
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
			$(".image-upload").show();
			$(".dismiss").show();
		}
	})
	var stop=true;   
	var per_page = 5;
  function loadData(){   
      totalheight = parseFloat($(window).height()) + parseFloat($(window).scrollTop());   
        
      if ($(document).height() <= totalheight) {  
        var data = {}; 

        var currentcount = parseInt($('#tweet-feed').data("currentcount"));  
        var maxpage = parseInt($('#tweet-feed').data("maxpage"));
        if(currentcount <  maxpage && stop==true){
          stop=false;
        	data.maxpage = maxpage;
          data.begin = currentcount;
            $.get( "/statuses",data,
					   function() {
							  $("#loading").fadeIn();
							})
						  .done(function() {
						    $("#loading").fadeOut();
								$("#tweet-feed").append($($("#page-cache").html()).hide().fadeIn(1000));
								var end = parseInt($('#tweet-feed').data("currentcount"))+per_page;
			          end = (end <= maxpage )? end:maxpage;
						    $('#tweet-feed').data("currentcount", end)
						    stop=true; 
						  })
						  .fail(function() {
						    alert( "error" );
						    stop=true;
						  })
				}
      }   
    }   
    $(window).scroll( function() {   
        loadData();  
    });   


})