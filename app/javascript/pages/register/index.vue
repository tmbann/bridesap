<template>
  <v-container class="text-center mb-15">
    <h1 class="font-weight-bold mt-3 mb-3 gray--text">
      ユーザー登録
    </h1>
    <validation-observer
      ref="observer"
      v-slot="ObserverProps"
    >
      <form @submit.prevent="submit">
        <validation-provider
          name="ニックネーム"
          rules="required"
        >
          <div slot-scope="ProviderProps">
            <v-text-field
              v-model="user.name"
              label="ニックネーム"
              required
            ></v-text-field>
            <span class="pink--text">{{ ProviderProps.errors[0] }}</span>
          </div>
        </validation-provider>

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
              id="password"
              v-model="user.password"
              label="パスワード"
              required
            ></v-text-field>
            <span class="pink--text">{{ ProviderProps.errors[0] }}</span>
          </div>
        </validation-provider>

        <validation-provider
          name="password_confirmation"
          rules="required|min:8|password_confirmed:@パスワード"
        >
          <div slot-scope="ProviderProps">
            <v-text-field
              v-model="user.password_confirmation"
              label="パスワード（確認）"
              required
            ></v-text-field>
            <span class="pink--text">{{ ProviderProps.errors[0] }}</span>
          </div>
        </validation-provider>
      
        <v-row>
          <v-col>
            <template>
              <div>
                <div class="mb-6">以下は任意項目です。: <code>{{ activePicker || '現在未選択です' }}</code></div>
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
                <div class="mb-6">以下は任意項目です。: <code>{{ activePicker || '現在未選択です' }}</code></div>
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
          :disabled="ObserverProps.invalid || !ObserverProps.validated"
          @click="register"
          rounded
          color="primary"
        >
          <v-icon>mdi-account</v-icon>
          登録＆ありのままのあなたを撮影
        </v-btn>
        <p class="pink--text text-center mt-5">{{ errorMessage }}</p>
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
      activePicker: null,
      errorMessage: ''
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
      try {
        await
          this.registerUser(this.user)
          this.$router.push({ name: 'PurePose' })
      } catch (error) {
        console.log(error.response);
        this.errorMessage = error.response.data.errors.detail;
        this.$store.dispatch("setFlash", {
          type: "error",
          message: "登録できませんでした"
        })
      } 
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