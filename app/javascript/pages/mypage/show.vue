<template>
  <v-container>
    <v-col cols="12">
      <template v-if="user.pre_shoot_date">
        <p>前撮りまであと●日</p>
      </template>
      <template v-if="user.wedding_date">
        <p>結婚式まであと●日</p>
      </template>
    </v-col>

    <v-col cols="12">
      <v-row justify="center">
        <router-link
          :to="{ name: 'Pose' }"
          class="nav-link"
        >
          <v-btn
            elevation="5"
            rounded color="pink lighten-2"
            class="white--text mb-3"
          >
            Shooting Start
          </v-btn>
        </router-link>
      </v-row>
    </v-col>

    <v-col cols="12">
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
                color="pink lighten-3"
                class="white--text"
                v-bind="attrs"
                v-on="on"
              >
                Mypage Edit
              </v-btn>
            </template>
            <v-card>
              <v-card-title>
                <span class="text-h5">Mypage Edit</span>
              </v-card-title>
              <v-card-text>
                <v-container>
                  <v-row>
                    <v-col
                      cols="12"
                      sm="6"
                      md="4"
                    >
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
                          <v-btn
                            text
                            type="submit"
                            :disabled="invalid"
                            @click="handleUpdateUser"
                          >
                            Update
                          </v-btn>
                          <v-btn
                            text
                            @click="dialog = false"
                          >
                            Close
                          </v-btn>
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

    <v-col cols="12">
      <h2>判定結果</h2>
      <br />
      <div>
        <img :src="purePose.pure_image" />
        <template v-if="purePose.pure_pose">
          <h3>{{ purePose.pure_pose.pure_shoulder_width }}</h3>
        </template>
      </div>
      <div>
        <img :src="bestPose.best_image" />
        <template v-if="bestPose.best_pose">
          <h3> {{ bestPose.best_pose.shoulder_width }} </h3>
        </template>
      </div>
    </v-col>
  </v-container>
</template>

<script>
import { mapGetters, mapActions } from "vuex"

export default {
  name: 'Mypage',
  data () {
    return {
      dialog: false,
      ps_menu: null,
      w_menu: null,
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
    }
  },
  created() {
    this.fetchUser(),
    this.fetchPurePose(),
    this.fetchBestPose()
  }
}
</script>

<style scoped>
.nav-link {
  text-decoration: none;
}
</style>