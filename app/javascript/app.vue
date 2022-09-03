<template>
  <v-app>
    <TheHeader />
    <v-main class="bg">
      <TheFlashMessage v-if="isFlash" />
      <router-view />
    </v-main>
    <TheFooter />
  </v-app>
</template>

<script>
import TheHeader from "./components/TheHeader.vue";
import TheFooter from "./components/TheFooter.vue";
import TheFlashMessage from "./components/TheFlashMessage.vue";
import { mapGetters } from "vuex";

export default {
  components: {
    TheHeader,
    TheFooter,
    TheFlashMessage
  },
  computed: {
    ...mapGetters(["isFlash"])
  }
}
</script>

<style scoped>
.bg {
  background-image: url('../assets/images/background.jpeg');
  background-size: cover;
}
</style>
