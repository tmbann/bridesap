<template>
  <v-container>
    <v-col>
      <p class="text-center mb-5">
        カメラに<strong class="bgc">頭頂部〜胸部</strong>が映るようにしてください。全身をカメラに映す必要はありません。
      <br>
        <strong class="bgc">華奢に写るポイント</strong>を確認して撮影しましょう！
      <br>
        撮影の準備ができたらスタートボタンを押してください。10秒カウントダウンが始まります。
      </p>
    </v-col>
    <v-row
      dense
      justify="center"
      class="mt-5 mb-5"
    >
      <v-col
        cols="12"
        md="6"
        lg="6"
      >
        <v-card>
          <v-card-title class="py-2 card-font font-weight-bold">
            華奢に写るポイント
          </v-card-title>
          <v-list
            v-for="point in points"
            :key="point.id"
            class="py-0"
            dense
          >
            <v-list-item>
              <v-icon
                class="me-2"
                color="accent"
              >
                mdi-star
              </v-icon>
              <span class="text-subtitle-2 card-font font-weight-bold">{{ point.content }}</span>
            </v-list-item>
          </v-list>
        </v-card>
      </v-col>
    </v-row>
    <h1 class="text-center mt-15"><span class="bgc">{{ countDown }} 秒キープ！</span></h1>
    <v-row justify="center">
      <v-col>
        <v-card class="mt-3 text-center">
          <video
            ref="video"
            width="500"
            height="500"
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
            width="500"
            height="500"
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
        <v-icon>mdi-fire</v-icon>
        判定！
        <template v-slot:loader>
          <span>判定中…</span>
          <span class="custom-loader">
            <v-icon>mdi-sync</v-icon>
          </span>
        </template>
      </v-btn>
    </v-row>
  </v-container>
</template>

<script>
import { mapActions } from "vuex"

export default {
  name: 'Pose',
  data () {
    return {
      video: {},
      canvas: {},
      image: null,
      shoulder_width: null,
      countDown: 10,
      timer: null,
      points: [
        {
          id: 1,
          content: '首を長く見せるイメージで、肩をできるだけ下に落とす'
        },
        {
          id: 2,
          content: '肩をできるだけ落とした状態のまま、肩甲骨をくっつけるイメージで寄せる'
        }
      ],
      isLoading: false
    }
  },
  //computed: {
  //  width () {
  //    switch (this.$vuetify.breakpoint.name) {
  //      case 'xs': return 300
  //      case 'md': return 500
  //    } 
  //  },
  //  height () {
  //    switch (this.$vuetify.breakpoint.name) {
  //      case 'xs': return 300
  //      case 'md': return 500
  //    }
  //  }
  //},
  mounted () {
    this.video = this.$refs.video
    if (navigator.mediaDevices && navigator.mediaDevices.getUserMedia) {
      navigator.mediaDevices.getUserMedia({ video: true }).then(stream => {
        this.video.srcObject = stream
        this.video.play()
      })
    }
  },
  methods: {
    ...mapActions("poses", ["createPose"]),
    shooting() {
      const takeCapture = function(inst){
        inst.canvas = inst.$refs.canvas
        // canvas.getContext('2d')でcanvasを2Dグラフィックを描画するためのメソッドやプロパティをもつオブジェクトにする
        // drawImageは<canvas> 要素の二次元文脈に於いて、任意の位置に任意の画像類を貼付けるメソッド
        inst.canvas.getContext('2d').drawImage(inst.video, 0, 60, 500, 380)
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

      const poses = async() => {
        const detector = await poseDetection.createDetector(poseDetection.SupportedModels.MoveNet)
        const imageElement = document.getElementById('canvas')
        const poses = await detector.estimatePoses(imageElement)

        const leftShoulder = poses[0].keypoints[5].x
        const rightShoulder = poses[0].keypoints[6].x
        const shoulderWidth = leftShoulder - rightShoulder
        this.shoulder_width = shoulderWidth
      }
      const posesSubmit = async() => {
        await poses();
        let pose_image = this.image
        if (pose_image) {
          const formData = new FormData()
          formData.append('pose[image]', pose_image)
          formData.append('pose[shoulder_width]', this.shoulder_width)
      
          await this.createPose(formData)

          this.isLoading = false
          this.$router.push({ name: 'Result' })
        }
      }
      posesSubmit();
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