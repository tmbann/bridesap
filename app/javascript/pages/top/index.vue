<template>
  <v-container>
    <v-row class="text-center">
      <v-col class="top">
        <v-img :src="top_src"  width="100%" />
        <h1 class="white--text">
          B R I D E S A P
        </h1>
      </v-col>

      <v-col class="mt-12">
        <span class="bgc text-h6 font-weight-bold">BRIDESAPとは?</span>
        <p>他撮り頻発イベント「前撮り」「結婚式」に向けて、華奢に写る姿勢を練習するアプリです。</p>
      </v-col>

      <v-col cols="12" class="mt-10">
        <span class="bgc text-h6 font-weight-bold">
          練習の流れ
        </span>
        <v-row dense class="mb-5" justify="center">
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
        <template v-if="!authUser">
          <router-link
            :to="{ name: 'RegisterIndex' }"
            class="nav-link"
          >
            <v-btn elevation="5" rounded color="primary" class="white--text">
              <v-icon>mdi-account</v-icon>
              登録
            </v-btn>
          </router-link>
          <p class="subheading font-weight-regular red--text mt-3">
            まずはユーザー登録から
          </p>
        </template>
        <template v-else>
          <router-link
            :to="{ name: 'Pose' }"
            class="nav-link"
          >
            <v-btn elevation="5" rounded color="primary" class="white--text mb-5">
              <v-icon>mdi-camera</v-icon>
              撮影
            </v-btn>
          </router-link>
        </template>
      </v-col>
    </v-row>
  </v-container>
</template>

<script>
import { mapGetters } from "vuex"

export default {
  data() {
    return {
      top_src: require('../../../assets/images/top.jpeg'),
      cards: [
        {
          title: 'ありのままのあなたを撮影',
          text: 'ユーザー情報を登録後、まずはありのままの姿勢で撮影。現状を把握しましょう。ありのままのあなたを撮影できるのはユーザー登録時のみです。'
        },
        {
          title: 'ポイント確認＆撮影',
          text: 'ログイン後、「華奢に写るポイント」を確認した上で再度撮影しましょう。撮影時は「世界で一番あーしがかわいい」というマインドを忘れずに。'
        },
        {
          title: '判定',
          text: '「ありのままのあなた」と「ポイントを意識して撮影したあなた」を比較。ありのままのあなたからどれだけ華奢になれたか確認しましょう。'
        }
      ]
    }
  },
  computed: {
    ...mapGetters("users", ["authUser"])
  },
}
</script>

<style scoped>
.nav-link {
  text-decoration: none;
}

.top {
  position: relative;
}

.top h1 {
  position: absolute;
  top: 50%;
  left: 50%;
  -ms-transform: translate(-50%,-50%);
  -webkit-transform: translate(-50%,-50%);
  transform: translate(-50%,-50%);
  margin:0;
  padding:0;
  font-family: 'Gill Sans', 'Gill Sans MT', Calibri, 'Trebuchet MS', sans-serif;
}

.bgc {
  background: linear-gradient(transparent 60%, #F8BBD0 60%);
  border-radius: 5px;
}
</style>