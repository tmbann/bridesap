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

      <HowToUse />

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
          <p class="subheading font-weight-regular pink--text mt-3">
            まずはユーザー登録から
          </p>
        </template>
        <template v-else>
          <SwitchButton />
        </template>
      </v-col>
    </v-row>
  </v-container>
</template>

<script>
import { mapGetters } from "vuex"
import HowToUse from "../../components/HowToUse.vue"
import SwitchButton from "../../components/SwitchButton.vue";

export default {
    data() {
      return {
        top_src: require("../../../assets/images/top.jpeg")
      };
    },
    computed: {
        ...mapGetters("users", ["authUser"]),
    },
    components: { HowToUse, SwitchButton }
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