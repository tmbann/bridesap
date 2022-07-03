<template>
  <validation-observer
    ref="observer"
    v-slot="{ invalid }"
  >
    <form @submit.prevent="submit">
      <validation-provider
        v-slot="{ errors }"
        name="email"
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
        name="password"
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
      >
        ログイン
      </v-btn>
    </form>
  </validation-observer>
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
        this.$router.push({ name: 'TopIndex' }) //後でマイページ遷移に変更
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