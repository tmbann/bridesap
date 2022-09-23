<template>
  <div>
    <template v-if="purePose.pure_pose">
      <v-list-item>
        <v-icon>mdi-camera</v-icon>
        <router-link
          :to="{ name: 'Pose' }"
          class="nav-link"
        >
          <v-list-item-title>撮影</v-list-item-title>
        </router-link>
      </v-list-item>
    </template>
    <template v-else>
      <v-list-item>
        <v-icon>mdi-camera</v-icon>
        <router-link
          :to="{ name: 'PurePose' }"
          class="nav-link"
        >
          <v-list-item-title>ありのままのあなたを撮影</v-list-item-title>
        </router-link>
      </v-list-item>
    </template>
  </div>
</template>

<script>
import { mapGetters, mapActions } from "vuex"

export default {
  name: 'SwitchLink',
  computed: {
    ...mapGetters("poses", ["purePose"])
  },
  methods: {
    ...mapActions("poses", ["fetchPurePose"])
  },
  created() {
    this.fetchPurePose();
  },
}
</script>

<style scoped>
.nav-link {
  text-decoration: none;
  color: gray;
}
</style>