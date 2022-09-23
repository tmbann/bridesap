<template>
  <div>
    <template v-if="purePose.pure_pose">
      <v-col cols="12">
        <v-row justify="center">
          <router-link
            :to="{ name: 'Pose' }"
            class="nav-link"
          >
            <v-btn
              elevation="5"
              rounded
              color="primary"
              class="white--text mb-3"
            >
              <v-icon>mdi-camera</v-icon>
              撮影
            </v-btn>
          </router-link>
        </v-row>
      </v-col>
    </template>
    <template v-else>
      <v-col cols="12">
        <v-row justify="center">
          <router-link
            :to="{ name: 'PurePose' }"
            class="nav-link"
          >
            <v-btn
              elevation="5"
              rounded
              color="primary"
              class="white--text mb-3"
            >
              <v-icon>mdi-camera</v-icon>
              ありのままのあなたを撮影
            </v-btn>
          </router-link>
        </v-row>
      </v-col>
    </template>
  </div>
</template>

<script>
import { mapGetters, mapActions } from "vuex"

export default {
  name: 'SwitchButton',
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