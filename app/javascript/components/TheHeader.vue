<template>
  <header>
    <v-app-bar absolute app dense flat color="transparent">
      <v-toolbar-title></v-toolbar-title>
      <v-spacer />
      <v-app-bar-nav-icon @click="drawer = true">=</v-app-bar-nav-icon>
    </v-app-bar>
    <v-navigation-drawer v-model="drawer" fixed temporary>
      <v-list nav dense>
        <v-list-item v-for="(item, index) in items" :key="index">
          <v-list-item-title>{{ item.title }}</v-list-item-title>
        </v-list-item>
      </v-list>
    </v-navigation-drawer>
  </header>
</template>

<script>
export default {
  name: 'TheHeader',
  data () {
    return {
      drawer: false,
      items: [
        { title: 'ログイン' },
        { title: 'ユーザー登録' },
        { title: '撮影' },
        { title: 'マイページ' }
      ]
    }
  }
}
</script>

<style scoped>
</style>