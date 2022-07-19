<template>
  <v-container>
    <v-row class="text-center">
      <v-col cols="12">
        <h1 class="font-weight-bold mb-3 pink--text">
          BRIDESAP
        </h1>
      </v-col>

      <v-col cols="12">
        <p class="grey--text">他撮り頻発イベント「前撮り」「結婚式」に向けて、綺麗に写る姿勢を練習するアプリです</p>
      </v-col>

      <v-col cols="12">
        <p class="text-center text-h6 mb-2 font-weight-bold grey--text">
          基本姿勢
        </p>
        <v-row dense class="mb-12" justify="center">
          <v-col 
            v-for="(card, index) in cards"
            :key="card.title"
            cols="10"
            md="4"
            lg="3"
            xl="2"
            class="mb-3"
          >
            <v-card rounded class="rounded-xl">
              <p class="text-button text-center mb-2">
                Step{{ index + 1 }}
              </p>
              <v-card-title class="py-1">
                {{ card.title }}
              </v-card-title>
              <v-card-text>
                {{ card.text }}
              </v-card-text>
            </v-card>
          </v-col>
        </v-row>
      </v-col>

      <v-col cols="12">
        <router-link
          :to="{ name: 'Pose' }"
          class="nav-link"
        >
          <v-btn elevation="5" rounded color="pink lighten-2" class="white--text">撮影</v-btn>
        </router-link>
      </v-col>
      <v-col cols="12">
        <router-link
          :to="{ name: 'RegisterIndex' }"
          class="nav-link"
        >
          <v-btn elevation="5" rounded color="pink lighten-3" class="white--text">ユーザー登録</v-btn>
        </router-link>
        <p class="subheading font-weight-regular pink--text mt-3">
          判定結果を保存するには、ユーザー登録が必要です
        </p>
      </v-col>
    </v-row>
  </v-container>
</template>

<script>
export default {
  data() {
    return {
      cards: [
        {
          title: '肩をできるだけ落とす',
          text:  '肩を落とし、首を長く見せて小顔に'
        },
        {
          title: '肩甲骨を寄せる',
          text: '肩甲骨を寄せて華奢見え'
        }
      ]
    }
  }
}
</script>

<style scoped>
.nav-link {
  text-decoration: none;
}
</style>