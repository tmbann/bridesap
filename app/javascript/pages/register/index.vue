<template>
  <v-container class="text-center mb-15">
    <h1 class="font-weight-bold mt-3 mb-3 gray--text">
      ユーザー登録
    </h1>
    <validation-observer
      ref="observer"
      v-slot="{ invalid }"
    >
      <form @submit.prevent="submit">
        <validation-provider
          v-slot="{ errors }"
          name="ニックネーム"
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
          rules="required|min:8|password_confirmed:@パスワード"
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
            <template>
              <div>
                <div class="mb-6">任意項目: <code>{{ activePicker || '現在未選択です' }}</code></div>
                <v-menu
                  ref="ps_menu"
                  v-model="ps_menu"
                  :close-on-content-click="false"
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
                    :active-picker.sync="activePicker"
                    color="pink lighten-4"
                    max="2050-01-01"
                    :min="(new Date(Date.now() + ((new Date().getTimezoneOffset() + (9 * 60)) * 60 * 1000))).toISOString().substr(0, 10)"
                    @change="ps_save"
                  ></v-date-picker>
                </v-menu>
              </div>
            </template>
          </v-col>

          <v-col>
            <template>
              <div>
                <div class="mb-6">任意項目: <code>{{ activePicker || '現在未選択です' }}</code></div>
                <v-menu
                  ref="w_menu"
                  v-model="w_menu"
                  :close-on-content-click="false"
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
                    :active-picker.sync="activePicker"
                    color="pink lighten-4"
                    max="2050-01-01"
                    :min="(new Date(Date.now() + ((new Date().getTimezoneOffset() + (9 * 60)) * 60 * 1000))).toISOString().substr(0, 10)"
                    @change="w_save"
                  ></v-date-picker>
                </v-menu>
              </div>
            </template>
          </v-col>
        </v-row>
        <v-btn
          class="mt-5"
          type="submit"
          :disabled="invalid"
          @click="register"
          rounded
          color="primary"
        >
          <v-icon>mdi-account</v-icon>
          登録＆ありのままのあなたを撮影
        </v-btn>
      </form>
    </validation-observer>
  </v-container>
</template>

<script>
import { mapGetters, mapActions } from "vuex"

export default {
  name: "RegisterIndex",
  data () {
    return {
      user: {
        name: '',
        email: '',
        password: '',
        password_confirmation: '',
        pre_shoot_date: null,
        wedding_date: null
      },
      ps_menu: false,
      w_menu: false,
      activePicker: null
    }
  },
  watch: {
    menu (val) {
      val && setTimeout(() => (this.activePicker = 'YEAR'))
    },
  },
  computed: {
    ...mapGetters("users", ["registeringUserId"])
  },
  methods: {
    ...mapActions("users", ["registerUser"]),
    submit () {
      this.$refs.observer.validate()
    },
    async register() {
      await this.registerUser(this.user)
      this.$router.push({ name: 'PurePose' })
    },
    ps_save (date) {
      this.$refs.ps_menu.save(date)
    },
    w_save(date) {
      this.$refs.w_menu.save(date)
    }
  }
}
</script>

<style scoped>
</style>