<template>
  <v-container>
    <p><strong>{{ countDown }}</strong> 秒キープ！</p>
    <video ref="video" width="500" height="500" autoplay class="mb-2 mt-2 mx-3"></video>
    <canvas id="canvas" ref="canvas" width="500" height="500" class="mb-2 mt-4 mx-3"></canvas>
    <v-row justify="center" class="mb-5">
      <v-btn class="mx-3" @click="shooting">Start</v-btn>
      <v-btn class="mx-3" @click="reset">Reset</v-btn>
      <v-btn class="mx-3" @click="submit">Submit</v-btn>
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
      timer: null
    }
  },
  mounted () {
    this.video = this.$refs.video
    if (navigator.mediaDevices && navigator.mediaDevices.getUserMedia) {
      navigator.mediaDevices.getUserMedia({ video: true }).then(stream => {
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
            console.log(res.data)
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
</style>