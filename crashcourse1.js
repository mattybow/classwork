parseJSON = function(){
	var parsedJSON = JSON.parse(this.responseText);
	return parsedJSON.frames['chaingun_impact.png'].spriteSourceSize.x;
};
var setup = function(){
	oReq = new XMLHttpRequest();
	oReq.open("GET","filename",true);
	oReq.onload = parseJSON;
	//or
	/*oReq.onload = function() {
	        var parsedJSON = JSON.parse(this.responseText);
	        console.log(parsedJSON['frames']['chaingun_impact.png']['spriteSourceSize']['x']);
	    };*/
	oReq.send();
};
