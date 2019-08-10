import 'package:dartleaf/src/leaflet_map.dart';
import 'package:dartleaf/dartleaf.dart';
import 'draw.dart';

class DrawCircles implements Draw{
  final LeafletMap _map;
  LatLng _centerCoord;
  Point _centerPoint;
  CircleMarker _circleMarker;

  DrawCircles(this._map);

  @override
  set active(bool draw) {
    if (draw) {
      _map.on(E.mousedown, _drawCircleStart);
      _map.on(E.mousemove, _drawCircle);
    } else {
      _map.off(E.mousedown);
      _map.off(E.mouseup);
      _map.off(E.mousemove);
    }
  }

  void _drawCircleStart(MouseEvent e) {
    print("invoked draw circle start");
    if (_circleMarker != null) {
      _drawCircleEnd(e);
      return;
    }
    _centerCoord = e.latlng;
    _centerPoint = e.layerPoint;
    var options = CircleOptions()
      ..color = 'red'
      ..fillColor = '#f03'
      ..fillOpacity = 0.5
      ..radius = 25;

    _circleMarker = CircleMarker(_centerCoord, options);
    _circleMarker.addTo(_map);
  }


  void _drawCircleEnd(MouseEvent e) {
    print("draw circle end");
    _centerCoord = null;
    _centerPoint = null;
    _circleMarker = null;
  }

  void _drawCircle(MouseEvent e) {
    if (_centerPoint == null) return;
    print("drawing circle");
    var p = e.layerPoint;
    _circleMarker.setRadius(p.distanceTo(_centerPoint));
  }
}