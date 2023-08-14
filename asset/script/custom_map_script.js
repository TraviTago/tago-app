// 스타일 정의
var styleElement = document.createElement("style");
styleElement.type = "text/css";
styleElement.innerHTML = `
        .customoverlay {
          position: relative;
          top: 40px;
          border-radius: 10px;
          border: 1px solid #ccc;
          border-bottom: 2px solid #ddd;
          float: left;
          background-color: #fff;
        }
        .customoverlay a {
          display: block;
          text-decoration: none;
          color: #000;
          text-align: center;
          border-radius: 10px;
          font-size: 15px;
          font-weight: bold;
          overflow: hidden;
          background: #fff url(https://t1.daumcdn.net/localimg/localimages/07/mapapidoc/arrow_white.png) no-repeat right 14px center;
        }
        .customoverlay .title {
          display: block;
          text-align: center;
          padding: 2px 5px;
        }
       
      `;
document.head.appendChild(styleElement);

var markers = [];

function addCustomMarkerAndOverlay(position, title, imageSrc) {
  // 마커 이미지 설정
  var imageSize = new kakao.maps.Size(36, 50),
    imageOption = { offset: new kakao.maps.Point(18, 45) };

  var markerImage = new kakao.maps.MarkerImage(
      imageSrc,
      imageSize,
      imageOption
    ),
    markerPosition = position;

  var marker = new kakao.maps.Marker({
    position: markerPosition,
    image: markerImage,
  });

  marker.setMap(map);

  // Custom Overlay content
  var content =
    '<div class="customoverlay">' +
    '  <a href="https://map.kakao.com/link/map/11394059" target="_blank">' +
    '    <span class="title">' +
    title +
    "</span>" +
    "  </a>" +
    "</div>";

  var customOverlay = new kakao.maps.CustomOverlay({
    map: map,
    position: position,
    content: content,
    yAnchor: 1,
  });
}
var zoomControl = new kakao.maps.ZoomControl();
map.addControl(zoomControl, kakao.maps.ControlPosition.RIGHT);
