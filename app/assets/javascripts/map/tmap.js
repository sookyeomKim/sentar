/*document.write("<script  language='javascript' src='https://apis.skplanetx.com/tmap/js?version=1&format=javascript&appKey=30c68bc1-8813-3f13-9c99-d3660cf91545'></script>");  */

var map;//홈쪽 맵 
//var map_shelter_create;//쉘터생성쪽 맵
var zoom, mapW, mapH, mapDiv; //맵 초기화시 사용상수
//var mapDiv_shelter_create;
var lonlat, pr_3857, pr_4326; //좌표변환 관련 상수
var markers; //레이어 관련 변수

var initialize = function(){
	setVariables();
	map = new Tmap.Map({div:mapDiv});
	map.ctrl_panzoom.div.style.top= "50px"
	//map_shelter_create = new Tmap.Map({div:mapDiv_shelter_create});
	setLayers();
	shelterLoader();
};
$(initialize);
$(document).on('page:load',initialize);



function setVariables(){    
	pr_3857 = new Tmap.Projection("EPSG:3857");
	pr_4326 = new Tmap.Projection("EPSG:4326");
	lonlat = new Tmap.LonLat(14135893.887852,4518348.1852606);
	zoom = 16;
	mapDiv = 'map_div';
	//mapDiv_shelter_create = 'map_div_shelter_create';
}

function setLayers(){
	if(!map){
		varmsg ="map객체가 초기화되기 전에 레이어가 등록되었습니다."
		alert(msg);
		return;                                  
	}

	markers = new Tmap.Layer.Markers("MarkerLayer");
	map.addLayer(markers);
}

function get3857LonLat(coordX, coordY){//좌표변환메서드
	lonlat = map.getLonLatFromViewPortPx(coordX, coordY);
	lonlat.transform(pr_3857, pr_4326);
}

function onMarkerOver(e){//쉘터마커오버이벤트
}
function onMarkerOut(e){//쉘터마커아웃이벤트

}


/*tmap poi method*/
function tMapPoi(){//Poi매서드, 쉘터를 Poi를 이용해 띄워주자
	tData = new Tmap.TData();//response parameter를 *respnse parameter:sk서버내에 저장되어있는 map정보를 핸들링해줌
	/*가져온 데이터를 어떻게 처리할지 결정*/
	tData.events.register("onComplete", tData, onCompleteLoadGetPOIDataFromSearch);/*tData를 이용하여 oncompleete(100%)됐을 때 onCompleteLoadGetPOIDataFromSearch이용하여 처리*/
	tData.events.register("onProgress", tData, onProgressLoadPoiData);/**/
	tData.events.register("onError", tData, onErrorLoadPoiData);

	/*마크업에서의 검색값 */
	var searchText = $('#searchText').val();
	/*한글깨짐방지*/
	var encodingSearchText = encodeURIComponent(searchText);


	if (searchText != '') {//검색값이 공백이 아닐 때
		var options = {version : 1}
		/*poi관련된 값들을 처리해주는 method*/
		tData.getPOIDataFromSearch(encodingSearchText, options);
		$('#searchResult').css("display", "block");
	} else {
		alert('search POI Input.');
	}
}


function onProgressLoadPoiData() {

}

function onErrorLoadPoiData() {

}


/**/
function onCompleteLoadGetPOIDataFromSearch() {
	/*html공간선언*/
	$("#searchResult").html("");//수정 : 이부분 커머스 검색라인으로 옴기자
	var size = new Tmap.Size(22, 30);
	var offset = new Tmap.Pixel(-(size.w / 2), -size.h);

	if ($(this.responseXML).find("searchPoiInfo pois poi").text() != '') {

		$(this.responseXML).find("searchPoiInfo pois poi").each(
			/*통합검색이랑 지역검색만 넣어놨는데 필요한데로 추가 및 제거해야함*/
			function() {

				var name = $(this).find("name").text();

				var upperAddrName = $(this).find(
					"upperAddrName").text();

				var middleAddrName = $(this).find(
					"middleAddrName").text();

				var lowerAddrName = $(this).find(
					"lowerAddrName").text();

				var upperBizName = $(this).find(
					"upperBizName").text();

				var middleBizName = $(this).find(
					"middleBizName").text();

				var lowerBizName = $(this).find(
					"lowerBizName").text();

				var detailBizName = $(this).find(
					"detailBizName").text();				

				/*shelter에 대한 정보값도 받아와야 함 딱히 할 필요 엄슬 듯*/
				var coordX = $(this).find("frontLon")
				.text();

				var coordY = $(this).find("frontLat")
				.text();

				var trLonLat = get3857LonLat(coordX, coordY);//위도,경도좌표변환

				var nameArray = [];

				nameArray = name.split("(");

					if (name.length > 20) {
						name = nameArray[0] + '<br/>(' + nameArray[1];
					}

					if ($(this).index() >= 10) {//인덱스값 초과

						$("#searchResult").append(
							'<div><span class="num">'
							+ ($(this).index() + 1)
							+ '</span>&nbsp;<span class="imgSpan"><img src="img/sampleIcon.png"></span><span class="poiResultList"><a href="javascript:selectPoi('
								+ coordX + ',' + coordY
								+ ')"style="text-decoration:none; *margin-top:-10px;">'
						+ name
						+ '</a></span></div><br/><br/>');

						var icon = new Tmap.IconHtml("<img src='img/sampleIcon.png'/>", size, offset);//marker

					} else {

						$("#searchResult").append(
							'<div><span class="num">'
							+ ($(this).index() + 1)
							+ '</span>&nbsp;<span class="imgSpan"><img src="img/sampleIcon'
							+ ($(this).index() + 1)
							+ '.png"></span><span class="poiResultList"><a href="javascript:selectPoi('
								+ coordX + ',' + coordY
								+ ')"style="text-decoration:none;*margin-top:-10px;">'
						+ name
						+ '</a></span></div><br/><br/>');

						var icon = new Tmap.IconHtml(//marker
							"<img src='img/sampleIcon"
							+ ($(this).index() + 1)
							+ ".png'/>", size, offset);

					}

					var label = new Tmap.Label(
						"&nbsp;상호명 : " 
						+ name
						+ "<br/><br/>&nbsp;주소 : " 
						+ upperAddrName + " " 
						+ middleAddrName + "" 
						+ lowerAddrName
						+ "<br/><br/>&nbsp;구분 : " 
						+ upperBizName + "&nbsp;&gt;&nbsp;" 
						+ middleBizName + "&nbsp;&gt;&nbsp;" 
						+ lowerBizName + "&nbsp;&gt;&nbsp;" 
						+ detailBizName);


					var marker = new Tmap.Markers(new Tmap.LonLat(coordX, coordY), icon, label)

					/*재검색했을 때 마커 클리어*/
					if(markers!=null){
						markers.clearMarkers();
					}

					markers.addMarker(marker);

					marker.events.register('mouseover', marker,
						onMarkerOver);

					marker.events.register('mouseout', marker,
						onMarkerOut);

					main_search.submit;/*결과제출*/

				});

} else if ($(this.responseXML).find("error").text() != '') {

	var errorMessage = $(this.responseXML).find("error message").text();

	alert(errorMessage);

} else {

	alert('search Poi none');

}


/*검색시 줌 설정*/
if ($(this.responseXML).find("searchPoiInfo pois poi").text() != '') {

	map.zoomToExtent(markers.getDataExtent());

} else {

	map.setCenter(new Tmap.LonLat(14134074.680985, 4517814.0870894), 15);

	markers.clearMarkers();

	}
}



/*좌표값말고 다른것도 받아도된다*/
function shelterLoader(){

	var size = new Tmap.Size(35, 35);
	var offset = new Tmap.Pixel(-(size.w / 2), -size.h);

	/*다른사용자들쉘터좌표값받아오기*/
	/*var other_shelter;
	
	var shelter_cool_length = $(".shelter_lonlat").length;
	$(".shelter_lonlat").addClass(function(index) {
		return "shelter_lonlat" + index;
	});
	for (var i = 0; i < shelter_cool_length; i++) {
		$(".shelter_lonlat"+i).each(function(){
			other_shelter = $(".shelter_lonlat"+i).text();
			var other_shelter_split = other_shelter.replace(/lon=/gi,'');
			other_shelter_split = other_shelter_split.replace(/lat=/gi,'');
			other_shelter_split = other_shelter_split.replace(/\n/gi,'');
			other_shelter_split = other_shelter_split.replace(/^\s+|\s+$/gi,'');
			other_shelter_split_arr = other_shelter_split.split(',');
			
			var lon = other_shelter_split_arr[0];
			var lat = other_shelter_split_arr[1];

			//icon img넣는 곳
			var shelterIcon = new Tmap.IconHtml("<img src='../../assets/shelter/shelter.PNG'/>", size, offset);//marker

			var shelterMarker = new Tmap.Markers(new Tmap.LonLat(lon, lat), shelterIcon);

			markers.addMarker(shelterMarker);

			shelterMarker.events.register('mouseover', shelterMarker, onShelterOver);

			shelterMarker.events.register('mouseout', shelterMarker, onShelterOut);

			shelterMarker.events.register('click', shelterMarker, onShelterClick);
		});
	};*/

	/*ajax쉘터 정보들 받아오기*/
	$.ajax({
		type:"GET",
		url: "/shelters.json",		
		async:false,
		dataType: "json",             
		success: response_json,
		error: function(e){
		    	alert("error");
		}
	});
	function response_json(json){
		var main_location = location.toString().length;
		
		var shelter_list = json.shelters;

		var shelters_count=shelter_list.length;

		$.each(shelter_list,function(index){
			var shelter_info = shelter_list[index].Shelter;

			var shelter_id = shelter_info.id;		                	
	        	var shelter_name = shelter_info.name;
	        	var shelter_introduce = shelter_info.introduce;
	        	var shelter_lonlat = shelter_info.lonlat;
			
	        	var lonlat_split = shelter_lonlat.replace(/lon=/gi,'');
			lonlat_split = lonlat_split.replace(/lat=/gi,'');
			lonlat_split = lonlat_split.replace(/\n/gi,'');
			lonlat_split = lonlat_split.replace(/^\s+|\s+$/gi,'');
			lonlat_split_arr = lonlat_split.split(',');
			
			var lon = lonlat_split_arr[0];
			var lat = lonlat_split_arr[1];

			//icon img넣는 곳
			if(main_location<=44){
				var shelterIcon = new Tmap.IconHtml("<img src='assets/shelter/shelter.PNG'/>",size,offset);//marker					
			}else if(main_location>=55){
				var shelterIcon = new Tmap.IconHtml("<img src='../../assets/shelter/shelter.PNG'/>",size,offset);//marker					
			}
			var shelterMarker = new Tmap.Markers(new Tmap.LonLat(lon, lat), shelterIcon);

			/*var html;			
			html+="<div id='shelter_id_"+shelter_id+"'>";					
			html+="<span>"+shelter_name+"</span>";
			html+="<span>"+shelter_introduce+"</span>";
			html+="<a href='/shelters/"+shelter_id+"'>쉘터가기</a>"
			html+="</div>";*/

			var popup;
			popup = new Tmap.Popup("p1",new Tmap.LonLat(lon, lat),
			                        new Tmap.Size(250, 250),
			                        "<div id='shelter_id_"+shelter_id+"'>"
			                        +"<span>"+shelter_name+"</span>"
			                        +"<span>"+shelter_introduce+"</span>"
			                        +"<a href='/shelters/"+shelter_id+"'>쉘터가기</a>"
			                        +"</div>","close"
			                        ); 
			map.addPopup(popup);
			popup.hide();
			markers.addMarker(shelterMarker);

			if(main_location<=44){
			shelterMarker.events.register('mouseover', popup, onShelterOver);

			shelterMarker.events.register('mouseout', popup, onShelterOut);

			shelterMarker.events.register('click', popup, onShelterClick);
			}
			
		});
	}	
	/*ajax쉘터 정보들 받아오기 end*/

}


function onShelterOver(e){
}

function onShelterOut(e){
}

function onShelterClick(e){
	/*여기에 쉘터마커 클릭했을 때 쉘터로 이동하는거 만들기*/
	this.show();
}

function SetLonlatEvents(){//쉘터 생성할때 좌표 지정하기 위한 메서드
	map.events.register("click", map, onClickMap);
};

function onClickMap(e){ 
	markers.clearMarkers();
	
	lonlat = map.getLonLatFromViewPortPx(e.xy);
	//lonlat.transform(pr_3857, pr_4326);//좌표변환하면 마커가 생성이 안된다.
	/*alert(lonlat);*/ 


	/*$("#lon").val(lonlat.)
	$("#lat").val(lonlat.)*/
	$("#lonlat").val(lonlat);
	/*addMarker(lonlat);*/



	/*marker*/
	var size = new Tmap.Size(21,25);
	var offset = new Tmap.Pixel(-(size.w/2), -size.h);
	var icon = new Tmap.IconHtml('<img src="../../assets/shelter/shelter.PNG" style="z-index:9999px"/>',size,offset);
	/*var icon = new Tmap.IconHtml('<div class="shelter" style="border:10px solid black;"><div onClick="test1()" style="text-decoration: none;	color: RED;	font-size: 9pt;">AAAAAAAAA</div><div onClick="test2()"><img src="img/d.png" /></div><div onClick="test3()" style="text-decoration: none;	color: BLUE;	font-size: 9pt;">QQQQQQQQQQQQQQQQQQQqQ</div></div>',size,offset);*/
	var marker = new Tmap.Marker(lonlat,icon);
	markers.addMarker(marker);
}

