import 'bootstrap';
import 'mapbox-gl/dist/mapbox-gl.css'; // <-- you need to uncomment the stylesheet_pack_tag in the layout!

import { getUserLocation } from '../components/get_user_location';
import { initMapbox } from '../components/init_mapbox';

getUserLocation();
initMapbox();
