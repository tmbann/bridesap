<template>
  <header>
    <v-app-bar absolute app dense flat color="transparent">
      <v-toolbar-title></v-toolbar-title>
      <v-spacer />
      <v-app-bar-nav-icon @click="drawer = true"></v-app-bar-nav-icon>
    </v-app-bar>
    <v-navigation-drawer v-model="drawer" fixed temporary>
      <v-list nav dense>
        <template v-if="!authUser">
          <v-list-item>
            <router-link
              :to="{ name: 'TopIndex' }"
              class="nav-link"
            >
              TOP
            </router-link>
          </v-list-item>
          <v-list-item>
            <router-link
              :to="{ name: 'RegisterIndex' }"
              class="nav-link"
            >
              ユーザー登録
            </router-link>
          </v-list-item>
          <v-list-item>
            <router-link
              :to="{ name: 'LoginIndex' }"
              class="nav-link"
            >
              ログイン
            </router-link>
          </v-list-item>
        </template>
        <template v-else>
          <v-list-item>
            <router-link
              :to="{ name: '#' }"
              class="nav-link"
              @click.native="handleLogout"
            >
              <v-list-item-title>ログアウト</v-list-item-title>
            </router-link>
          </v-list-item>
        </template>
      </v-list>
    </v-navigation-drawer>
  </header>
</template>

<script>
import { mapGetters, mapActions } from "vuex"

export default {
  name: 'TheHeader',
  data () {
    return {
      drawer: false,
    }
  },
  computed: {
    ...mapGetters("users", ["authUser"])
  },
  methods: {
    ...mapActions("users", ["logoutUser"]),
    async handleLogout() {
      try {
        await this.logoutUser()
        this.$router.push({name: 'TopIndex'})
      } catch (error) {
        console.log(error)
      }
    }
  }
}
</script>

<style scoped>
</style>