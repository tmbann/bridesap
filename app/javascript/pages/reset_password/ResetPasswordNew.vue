<template>
  <v-container class="text-center">
    <h1 class="font-weight-bold mt-3 mb-3 gray--text">
      パスワードリセット申請
    </h1>
    <validation-observer
      ref="observer"
      v-slot="ObserverProps"
    >
      <form @submit.prevent="submit">
        <validation-provider
          name="メールアドレス"
          rules="required|email"
        >
          <div slot-scope="ProviderProps">
            <v-text-field
              v-model="email"
              label="メールアドレス"
              required
            ></v-text-field>
            <span class="pink--text">{{ ProviderProps.errors[0] }}</span>
          </div>
        </validation-provider>
      
        <v-btn
          class="mr-4"
          type="submit"
          :disabled="ObserverProps.invalid || !ObserverProps.validated"
          @click="passwordReset"
          rounded
          color="primary"
        >
          <v-icon>mdi-email-outline</v-icon>
          申請
        </v-btn>
      </form>
    </validation-observer>
  </v-container>
</template>

<script>
import axios from "../../plugins/axios";

export default {
  name: 'ResetPasswordNew',
  data() {
    return {
      email: ""
    }
  },
  methods: {
    submit () {
      this.$refs.observer.validate()
    },
    async passwordReset() {
      await axios.post("password_resets", {email: this.email})
      this.$router.push({ name: "TopIndex" })
      this.$store.dispatch("setFlash", {
        type: "success",
        message: "申請メールを送信しました。",
      })
    }
  }
}
</script>

<style scoped>
</style>