<template>
  <v-container class="text-center">
    <h1 class="font-weight-bold mt-3 mb-3 gray--text">
      ログイン
    </h1>
    <validation-observer
      ref="observer"
      v-slot="{ invalid }"
    >
      <form @submit.prevent="submit">
        <validation-provider
          v-slot="{ errors }"
          name="メールアドレス"
          rules="required|email"
        >
          <v-text-field
            v-model="user.email"
            :error-messages="errors"
            label="メールアドレス"
            required
          ></v-text-field>
        </validation-provider>

        <validation-provider
          v-slot="{ errors }"
          name="パスワード"
          rules="required|min:8"
        >
          <v-text-field
            v-model="user.password"
            :error-messages="errors"
            label="パスワード"
            required
          ></v-text-field>
        </validation-provider>
      
        <v-btn
          class="mr-4"
          type="submit"
          :disabled="invalid"
          @click="login"
          rounded
          color="primary"
        >
          <v-icon>mdi-login</v-icon>
          ログイン
        </v-btn>
      </form>
    </validation-observer>
    <br />
    <br />
    <router-link
      :to="{ name: 'RegisterIndex' }"
    >
      <v-list-item-title>ユーザー登録はこちら</v-list-item-title>
    </router-link>
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
      }
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
        console.log(error);
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