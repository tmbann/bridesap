<template>
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
</template>

<script>
export default {
  name: 'HowToUse',
  data () {
    return {
      cards: [
        {
          title: "ありのままのあなたを撮影",
          text: "まずは何も意識せずに、ありのままの姿勢で撮影。撮影時は「あーしはありのままでも可愛いが？」というマインドを忘れずに。"
        },
        {
          title: "ポイント確認＆撮影",
          text: "「華奢に写るポイント」を確認した上で再度撮影。撮影時は「世界で一番あーしがかわいい」というマインドを忘れずに。"
        },
        {
          title: "判定",
          text: "「ありのままのあなた」と「ポイントを意識して撮影したあなた」を比較。ありのままのあなたからどれだけ華奢になれたか確認しましょう。"
        }
      ]
    }
  }
}
</script>

<style scoped>
.bgc {
  background: linear-gradient(transparent 60%, #F8BBD0 60%);
  border-radius: 5px;
}
</style>