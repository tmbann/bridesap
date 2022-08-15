<template>
  <v-container>
    <div class="text-center mb-15">
      <h3>「ありのままのあなた」から<span class="bgc">{{ pose.result.score }}ポイント</span>華奢になりました！！！</h3>
      <br />
      <img :src="pose.image" />
      <h3><span class="bgc">{{ pose.result.comment }}</span></h3>
    </div>
    <v-col cols="12" class="mb-10">
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
            <v-icon>mdi-fire</v-icon>
            再チャレンジ！
          </v-btn>
        </router-link>
      </v-row>
    </v-col>
  </v-container>
</template>

<script>
import { mapGetters } from "vuex"

export default {
  name: 'Result',
  computed: {
    ...mapGetters("poses", ["pose"])
  }
}
</script>

<style scoped>
.bgc {
  background: linear-gradient(transparent 60%, #F8BBD0 60%);
  border-radius: 5px;
}
</style>