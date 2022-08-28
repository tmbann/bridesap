<template>
  <v-footer padless color="pink lighten-4">
    <v-row justify="center" no-gutters>
      <v-col 
        v-for="link in links"
        :key="link.name"
        cols="11"
        md="4"
        lg="3"
        xl="2"
      >
        <v-list
          dense
          class="pt-0"
          color="pink lighten-4"
          shaped
        >
          <v-list-item
            class="mx-10"
            :to="link.to"
          >
            <v-list-item-title class="white--text font-weight-bold">
              {{ link.name }}
            </v-list-item-title>
            <v-icon 
              color="white"
            >
              mdi-chevron-right
            </v-icon>
          </v-list-item>
        </v-list>
      </v-col>
      <v-col class="py-4 text-center white--text" cols="12">©{{ new Date().getFullYear() }} Bridesap</v-col>
    </v-row>
  </v-footer>
</template>

<script>
export default {
  name: 'TheFooter',
  data() {
    return {
      links: [
        { name: '利用規約', to: {name: 'TheTerms'} },
        { name: 'プライバシーポリシー', to: {name: 'ThePolicy'} },
        { name: 'お問い合わせ', to: {name: 'TheContact'} }
      ]
    }
  }
}
</script>

<style scoped>
</style>