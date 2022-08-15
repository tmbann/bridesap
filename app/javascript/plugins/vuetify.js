import '@mdi/font/css/materialdesignicons.css'
import Vue from 'vue';
import Vuetify from 'vuetify';
import 'vuetify/dist/vuetify.min.css'

Vue.use(Vuetify);

export default new Vuetify({
  icons: {
    iconfont: 'mdi'
  },
  theme : {
    themes: {
      light: {
        primary: '#FF4081',
        secondary: '#FF80AB',
        accent: '#FFD059'
      }
    }
  }
});