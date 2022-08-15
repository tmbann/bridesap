<template>
  <v-app>
    <TheHeader />
    <v-main class="bg">
      <router-view />
    </v-main>
    <TheFooter />
  </v-app>
</template>

<script>
import TheHeader from "./components/TheHeader.vue";
import TheFooter from "./components/TheFooter.vue";

export default {
  components: {
    TheHeader,
    TheFooter
  }
}
</script>

<style scoped>
.bg {
  background-image: url('../assets/images/background.jpeg');
  background-size: cover;
}
</style>
