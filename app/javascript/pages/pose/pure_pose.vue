<template>
  <v-container>
    <v-col>
      <p class="text-center">
        カメラに<strong class="bgc">頭頂部〜胸部</strong>が映るようにしてください。全身をカメラに映す必要はありません。
      <br>
        まずは何も意識せず<strong class="bgc">ありのままのあなた</strong>を撮影しましょう！
      <br>
        撮影の準備ができたらスタートボタンを押してください。10秒カウントダウンが始まります。
      </p>
    </v-col>
    <h1 class="text-center mt-15"><span class="bgc">{{ countDown }} 秒キープ！</span></h1>
    <v-row justify="center">
      <v-col>
        <v-card class="mt-3 text-center">
          <video
            ref="video"
            width="300"
            height="300"
            autoplay
            playsinline
            class="mb-2 mt-2 mx-3"
          >
          </video>
        </v-card>
      </v-col>

      <v-col>
        <v-card class="mt-3 text-center">
          <canvas
            id="canvas"
            ref="canvas"
            width="300"
            height="300"
            class="mb-2 mt-2 mx-3"
          >
          </canvas>
        </v-card>
      </v-col>
    </v-row>
    <v-row justify="center" class="mt-5 mb-5">
      <v-btn color="primary" rounded class="mx-3" :disabled="isLoading" @click="shooting">
        <v-icon>mdi-camera</v-icon>
        スタート
      </v-btn>
      <v-btn color="secondary" rounded class="mx-3" :disabled="isLoading" @click="reset">
        <v-icon>mdi-reload</v-icon>
        リセット
      </v-btn>
      <v-btn color="primary" rounded class="mx-3" :loading="isLoading" :disabled="isLoading" @click="submit">
        <v-icon>mdi-account-plus</v-icon>
        ありのままのあなたを登録
        <template v-slot:loader>
          <span>登録中…</span>
          <span class="custom-loader">
            <v-icon>mdi-sync</v-icon>
          </span>
        </template>
      </v-btn>
    </v-row>
  </v-container>
</template>

<script>
import { mapGetters } from "vuex"

export default {
  name: 'PurePose',
  data () {
    return {
      video: {},
      canvas: {},
      image: null,
      pure_shoulder_width: null,
      countDown: 10,
      timer: null,
      isLoading: false
    }
  },
  mounted () {
    this.video = this.$refs.video
    const constraints = {
      video: {
        width: 300,
        height: 300,
      }
    };

    if (navigator.mediaDevices && navigator.mediaDevices.getUserMedia) {
      navigator.mediaDevices.getUserMedia(constraints).then(stream => {
        this.video.srcObject = stream
        this.video.play()
      })
    }
  },
  computed: {
    ...mapGetters("users", ["registeringUserId"])
  },
  methods: {
    shooting() {
      const takeCapture = function(inst){
        inst.canvas = inst.$refs.canvas
        // canvas.getContext('2d')でcanvasを2Dグラフィックを描画するためのメソッドやプロパティをもつオブジェクトにする
        // drawImageは<canvas> 要素の二次元文脈に於いて、任意の位置に任意の画像類を貼付けるメソッド
        inst.canvas.getContext('2d').drawImage(inst.video, 0, 0, 300, 300)
        inst.image = inst.canvas.toDataURL('image/jpeg')
      }
      const countDownTimer = function(inst){
        if(inst.countDown > 0) {
          inst.countDown -= 1
        }
      }
      // function関数内でVueインスタンスのthisを使用するために、変数instに代入
      let inst = this
      setTimeout(function(){takeCapture(inst)}, 10000)
      this.timer = setInterval(function(){countDownTimer(inst)}, 1000)
    },
    reset() {
      this.countDown = 10
      clearInterval(this.timer)
      this.canvas.getContext('2d').clearRect(0, 0, 500, 500)
    },
    submit() {
      this.isLoading = true

      const purePoses = async() => {
        const detector = await poseDetection.createDetector(poseDetection.SupportedModels.MoveNet)
        const imageElement = document.getElementById('canvas')
        const poses = await detector.estimatePoses(imageElement)

        const pureLeftShoulder = poses[0].keypoints[5].x
        const pureRightShoulder = poses[0].keypoints[6].x
        const pureShoulderWidth = pureLeftShoulder - pureRightShoulder
        this.pure_shoulder_width = pureShoulderWidth
      }
      const purePosesSubmit = async() => {
        await purePoses();
        let pure_pose_image = this.image
        if (pure_pose_image) {
          const formData = new FormData()
          formData.append('pure_pose[image]', pure_pose_image)
          formData.append('pure_pose[pure_shoulder_width]', this.pure_shoulder_width)
          formData.append('pure_pose[user_id]', this.registeringUserId)
      
          this.$axios.post('pure_poses', formData)
          .then(res => {
            this.isLoading = false
            this.$store.dispatch("setFlash", {
              type: "success",
              message: "登録しました",
            });
            this.$router.push({ name: 'LoginIndex' })
          })
        }
      }
      purePosesSubmit();
    }
  }
}
</script>

<style scoped>
.bgc {
  background: linear-gradient(transparent 60%, #F8BBD0 60%);
  border-radius: 5px;
}
.custom-loader {
  animation: loader 1s infinite;
  display: flex;
}
@-moz-keyframes loader {
  from {
    transform: rotate(0);
  }
  to {
    transform: rotate(360deg);
  }
}
@-webkit-keyframes loader {
  from {
    transform: rotate(0);
  }
  to {
    transform: rotate(360deg);
  }
}
@-o-keyframes loader {
  from {
    transform: rotate(0);
  }
  to {
    transform: rotate(360deg);
  }
}
@keyframes loader {
  from {
    transform: rotate(0);
  }
  to {
    transform: rotate(360deg);
  }
}
</style>