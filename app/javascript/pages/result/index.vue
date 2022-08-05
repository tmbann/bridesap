<template>
  <div>
    <h2>Score: {{ pose.result.score }} !!!</h2>
    <br />
    <img :src="pose.image" />
    <h3>{{ pose.result.comment }}</h3>
  </div>
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
</style>