<template>
  <v-container class="text-center">
    <h1 class="font-weight-bold mt-3 mb-3 gray--text">
      ログイン
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
              v-model="user.email"
              label="メールアドレス"
              required
            ></v-text-field>
            <span class="pink--text">{{ ProviderProps.errors[0] }}</span>
          </div>
        </validation-provider>

        <validation-provider
          name="パスワード"
          rules="required|min:8"
        >
          <div slot-scope="ProviderProps">
            <v-text-field
              v-model="user.password"
              label="パスワード"
              required
              :append-icon="show ? 'mdi-eye' : 'mdi-eye-off'"
              :type="show ? 'text' : 'password'"
              @click:append="show = !show"
            ></v-text-field>
            <span class="pink--text">{{ ProviderProps.errors[0] }}</span>
          </div>
        </validation-provider>
      
        <v-btn
          class="mr-4"
          type="submit"
          :disabled="ObserverProps.invalid || !ObserverProps.validated"
          @click="login"
          rounded
          color="primary"
        >
          <v-icon>mdi-login</v-icon>
          ログイン
        </v-btn>
        <p class="pink--text text-center mt-5">{{ errorMessage }}</p>
      </form>
    </validation-observer>
    <br />
    <br />
    <p class="text-center my-3">
      ユーザー登録は
      <router-link
        :to="{ name: 'RegisterIndex' }"
      >
        こちら
      </router-link>
    </p>
    <p class="text-center my-3">
      パスワードをお忘れの方は
      <router-link
        :to="{ name: 'ResetPasswordNew' }"
      >
        こちら
      </router-link>
    </p>
  </v-container>
</template>

<script>
import { mapActions } from 'vuex'

export default {
  name: 'LoginIndex',
  data() {
    return {
      user: {
        email: '',
        password: ''
      },
      errorMessage: "",
      show: false
    }
  },
  methods: {
    ...mapActions("users", [
      "loginUser",
      "fetchUser"
    ]),
    async login() {
      try {
        await this.loginUser(this.user);
        this.$router.push({ name: 'Mypage' })
      }catch(error) {
        console.log(error)
        this.errorMessage = error.response.data.errors.detail
        this.$store.dispatch("setFlash", {
          type: "error",
          message: "ログインできませんでした"
        })
      }
    },
    submit () {
      this.$refs.observer.validate()
    }
  }
}
</script>

<style scoped>
</style>