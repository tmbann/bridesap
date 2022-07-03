<template>
  <validation-observer
    ref="observer"
    v-slot="{ invalid }"
  >
    <form @submit.prevent="submit">
      <validation-provider
        v-slot="{ errors }"
        name="name"
        rules="required"
      >
        <v-text-field
          v-model="user.name"
          :error-messages="errors"
          label="ニックネーム"
          required
        ></v-text-field>
      </validation-provider>

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
        rules="required"
      >
        <v-text-field
          id="password"
          v-model="user.password"
          :error-messages="errors"
          label="パスワード"
          required
        ></v-text-field>
      </validation-provider>

      <validation-provider
        v-slot="{ errors }"
        name="password_confirmation"
        rules="required|min:8|password_confirmed:@password"
      >
        <v-text-field
          v-model="user.password_confirmation"
          :error-messages="errors"
          label="パスワード（確認）"
          required
        ></v-text-field>
      </validation-provider>
      
      <v-row>
        <v-col>
          <v-menu
            v-model="ps_menu"
            :close-on-content-click="true"
            :nudge-right="40"
            transition="scale-transition"
            offset-y
            min-width="auto"
          >
            <template v-slot:activator="{ on, attrs }">
              <v-text-field
                v-model="user.pre_shoot_date"
                label="前撮り"
                prepend-icon="mdi-calendar"
                readonly
                v-bind="attrs"
                v-on="on"
              ></v-text-field>
            </template>
            <v-date-picker
              v-model="user.pre_shoot_date"
              color="pink lighten-4"
            ></v-date-picker>
          </v-menu>
        </v-col>
        
        <v-col>
          <v-menu
            v-model="w_menu"
            :close-on-content-click="true"
            :nudge-right="40"
            transition="scale-transition"
            offset-y
            min-width="auto"
          >
            <template v-slot:activator="{ on, attrs }">
              <v-text-field
                v-model="user.wedding_date"
                label="結婚式"
                prepend-icon="mdi-calendar"
                readonly
                v-bind="attrs"
                v-on="on"
              ></v-text-field>
            </template>
            <v-date-picker
              v-model="user.wedding_date"
              color="pink lighten-4"
            ></v-date-picker>
          </v-menu>
        </v-col>
      </v-row>
      <v-btn
        class="mr-4"
        type="submit"
        :disabled="invalid"
        @click="register"
      >
        登録
      </v-btn>
    </form>
  </validation-observer>
</template>

<script>
export default {
  name: "RegisterIndex",
  data () {
    return {
      user: {
        name: '',
        email: '',
        password: '',
        password_confirmation: '',
        pre_shoot_date: (new Date(Date.now() - (new Date()).getTimezoneOffset() * 60000)).toISOString().substr(0, 10),
        wedding_date: (new Date(Date.now() - (new Date()).getTimezoneOffset() * 60000)).toISOString().substr(0, 10)
      },
      ps_menu: null,
      w_menu: null
    }
  },
  methods: {
    submit () {
      this.$refs.observer.validate()
    },
    register() {
      this.$axios.post('users', { user: this.user })
        .then(res => {
          this.$router.push({ name: 'LoginIndex' })
        })
        .catch(err => {
          console.log(err)
        })
    }
  }
}
</script>

<style scoped>
</style>