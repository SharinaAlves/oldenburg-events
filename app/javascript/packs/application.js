import 'bootstrap';
import 'mapbox-gl/dist/mapbox-gl.css'; // <-- you need to uncomment the stylesheet_pack_tag in the layout!
import '../components/flatpickr';

import { getUserLocation } from '../components/get_user_location';
import { initMapbox } from '../components/init_mapbox';
import { swiper } from '../components/swiper';

getUserLocation();
initMapbox();
swiper();

if (navigator.serviceWorker) {
  navigator.serviceWorker.register('/service-worker.js', { scope: './' })
    .then(function(reg) {
      console.log('[Companion]', 'Service worker registered!');
      console.log(reg);
    });
}
