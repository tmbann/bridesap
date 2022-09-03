<template>
  <transition name="fade">
    <v-row class="ml-5">
      <v-col cols="6">
        <div v-if="flash.type === 'success'" >
          <v-alert text shaped type="success">
            {{ flash.message }}
          </v-alert>
        </div>
        <div v-if="flash.type === 'error'">
          <v-alert text shaped type="error">
            {{ flash.message }}
          </v-alert>
        </div>
      </v-col>
    </v-row>
  </transition>
</template>
  
<script>
import { mapGetters } from "vuex";
export default {
  computed: {
    ...mapGetters(["flash"]),
  },
  mounted() {
    setTimeout(() => {
      this.$store.dispatch("setFlash", {
        type: "",
        flash: "",
      });
    }, 3000);
  },
};
</script>
  
<style scoped>
</style>