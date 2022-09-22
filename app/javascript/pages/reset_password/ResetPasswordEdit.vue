<template>
  <v-container class="text-center">
    <h1 class="font-weight-bold mt-3 mb-3 gray--text">
      パスワードリセット
    </h1>
    <validation-observer
      ref="observer"
      v-slot="ObserverProps"
    >
      <form @submit.prevent="submit">
        <validation-provider
          name="パスワード"
          rules="required|min:8"
        >
          <div slot-scope="ProviderProps">
            <v-text-field
              id="password"
              v-model="user.password"
              label="パスワード"
              required
              :append-icon="show1 ? 'mdi-eye' : 'mdi-eye-off'"
              :type="show1 ? 'text' : 'password'"
              @click:append="show1 = !show1"
            ></v-text-field>
            <span class="pink--text">{{ ProviderProps.errors[0] }}</span>
          </div>
        </validation-provider>

        <validation-provider
          name="パスワード（確認）"
          rules="required|min:8|password_confirmed:@パスワード"
        >
          <div slot-scope="ProviderProps">
            <v-text-field
              v-model="user.password_confirmation"
              label="パスワード（確認）"
              required
              :append-icon="show2 ? 'mdi-eye' : 'mdi-eye-off'"
              :type="show2 ? 'text' : 'password'"
              @click:append="show2 = !show2"
            ></v-text-field>
            <span class="pink--text">{{ ProviderProps.errors[0] }}</span>
          </div>
        </validation-provider>
      
        <v-btn
          class="mr-4"
          type="submit"
          :disabled="ObserverProps.invalid || !ObserverProps.validated"
          @click="changePassword"
          rounded
          color="primary"
        >
          <v-icon>mdi-lock-check-outline</v-icon>
          パスワード変更
        </v-btn>
      </form>
    </validation-observer>
  </v-container>
</template>

<script>
import axios from "../../plugins/axios";

export default {
  name: 'ResetPasswordEdit',
  data() {
    return {
      user: {
        password: "",
        password_confirmation: ""
      },
      show1: false,
      show2: false
    }
  },
  methods: {
    submit () {
      this.$refs.observer.validate()
    },
    async changePassword() {
      await axios.patch(`password_resets/${this.$route.query.token}`, {user: this.user})
      this.$router.push({ name: "TopIndex" });
      this.$store.dispatch("setFlash", {
        type: "success",
        message: "パスワードを変更しました。",
      })
    }
  }
}
</script>

<style scoped>
</style>