<template>
  <v-container>
    <v-col cols="12" class="mt-10 mb-15">
      <template v-if="user.pre_shoot_date">
        <h1 class="text-center">
          <span class="bgc">
            前撮りまであと
            <template v-if="diffDate(user.pre_shoot_date ,dateToday) <= 0">
              <strong>0</strong>
            </template>
            <template v-else>
              <strong>{{ diffDate(user.pre_shoot_date ,dateToday) + 1 }}</strong>
            </template>
            日
          </span>
        </h1>
      </template>
      <br />
      <br />
      <template v-if="user.wedding_date">
        <h1 class="text-center">
          <span class="bgc">
            結婚式まであと
            <template v-if="diffDate(user.wedding_date ,dateToday) <= 0">
              <strong>0</strong>
            </template>
            <template v-else>
              <strong>{{ diffDate(user.wedding_date ,dateToday) + 1 }} </strong>
            </template>
            日
          </span>
        </h1>
      </template>
    </v-col>

    <v-col cols="12" class="mb-10">
      <h2 class="text-center">あなたの記録</h2>
      <br />
      <v-row justify="center" class="text-center">
        <v-card class="card mx-2 my-3" min-width="525">
          <v-col>
            <template v-if="purePose.pure_pose">
              <h3>ありのままのあなた</h3>
              <p><span class="bgc">肩幅スコア：{{ purePose.pure_pose.pure_shoulder_width }}</span></p>
              <img :src="purePose.pure_image" />
            </template>
            <template v-else>
              <h3>ありのままのあなた</h3>
              <p><span class="bgc">肩幅スコア： 登録がありません</span></p>
            </template>
          </v-col>
        </v-card>
        <v-card class="card mx-2 my-3" min-width="525">
          <v-col>
            <template v-if="bestPose.best_pose">
              <h3>史上最高に華奢なあなた</h3>
              <p><span class="bgc">肩幅スコア：{{ bestPose.best_pose.shoulder_width }}</span></p>
              <img :src="bestPose.best_image" />
            </template>
            <template v-else>
              <h3>史上最高に華奢なあなた</h3>
              <p><span class="bgc">肩幅スコア： まだ華奢になっていません</span></p>
            </template>
          </v-col>
        </v-card>
      </v-row>
    </v-col>

    <v-col cols="12">
      <v-row justify="center">
        <router-link
          :to="{ name: 'Pose' }"
          class="nav-link"
        >
          <v-btn
            elevation="5"
            rounded
            color="primary"
            class="white--text mb-3"
          >
            <v-icon>mdi-camera</v-icon>
            撮影
          </v-btn>
        </router-link>
      </v-row>
    </v-col>

    <v-col cols="12" class="mb-10">
      <template>
        <v-row justify="center">
          <v-dialog
            v-model="dialog"
            persistent
            max-width="600px"
          >
            <template v-slot:activator="{ on, attrs }">
              <v-btn
                elevation="5"
                rounded
                color="secondary"
                class="white--text"
                v-bind="attrs"
                v-on="on"
              >
                <v-icon>mdi-cards-heart</v-icon>
                マイページ編集
              </v-btn>
            </template>
            <v-card>
              <v-card-title>
                <span class="text-h5">マイページ編集</span>
              </v-card-title>
              <v-card-text>
                <v-container>
                  <v-row>
                    <v-col>
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
                            >
                            </v-text-field>
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
                            >
                            </v-text-field>
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
                                  >
                                  </v-text-field>
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
                                  >
                                  </v-text-field>
                                </template>
                                <v-date-picker
                                  v-model="user.wedding_date"
                                  color="pink lighten-4"
                                ></v-date-picker>
                              </v-menu>
                            </v-col>
                          </v-row>
                          <div class="text-center">
                            <v-btn
                              text
                              type="submit"
                              :disabled="invalid"
                              @click="handleUpdateUser"
                            >
                              更新
                            </v-btn>
                            <v-btn
                              text
                              @click="dialog = false"
                            >
                              閉じる
                            </v-btn>
                          </div>
                        </form>
                      </validation-observer>
                    </v-col>
                  </v-row>
                </v-container>
              </v-card-text>
            </v-card>
          </v-dialog>
        </v-row>
      </template>
    </v-col>
  </v-container>
</template>

<script>
import { mapGetters, mapActions } from "vuex"
import dayjs from "dayjs"
import timezone from "dayjs/plugin/timezone"
import utc from "dayjs/plugin/utc"

dayjs.extend(timezone)
dayjs.extend(utc)

export default {
  name: 'Mypage',
  data () {
    return {
      dialog: false,
      ps_menu: null,
      w_menu: null,
      dateToday: ""
    }
  },
  computed: {
    ...mapGetters("users", ["user", "authUser"]),
    ...mapGetters("poses", ["purePose", "bestPose"])
  },
  methods: {
    ...mapActions("users", ["fetchUser", "updateUser"]),
    ...mapActions("poses", ["fetchPurePose", "fetchBestPose"]),
    submit () {
      this.$refs.observer.validate()
    },
    handleUpdateUser() {
      try {
        this.updateUser(this.user)
        this.dialog = false
      } catch (error) {
        console.log(error);
      }
    },
    diffDate: function(target_date, today) {
      return (dayjs(target_date).diff(today, 'days'))
    }
  },
  created() {
    this.fetchUser(),
    this.fetchPurePose(),
    this.fetchBestPose()
  },
  mounted() {
    this.dateToday = dayjs(new Date()).tz('Asia/Tokyo').format()
  }
}
</script>

<style scoped>
.nav-link {
  text-decoration: none;
}

.bgc {
  background: linear-gradient(transparent 60%, #F8BBD0 60%);
  border-radius: 5px;
}
</style>