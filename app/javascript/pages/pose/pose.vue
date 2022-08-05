<template>
  <v-container>
    <p><strong>{{ countDown }}</strong> 秒キープ！</p>
    <video ref="video" width="500" height="500" autoplay class="mb-2 mt-2 mx-3"></video>
    <canvas id="canvas" ref="canvas" width="500" height="500" class="mb-2 mt-4 mx-3"></canvas>
    <v-row justify="center" class="mb-5">
      <v-btn class="mx-3" @click="shooting">Start</v-btn>
      <v-btn class="mx-3" @click="reset">Reset</v-btn>
      <v-btn class="mx-3" @click="submit">judgment</v-btn>
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
          this.$router.push({ name: 'Result' })
        }
      }
      posesSubmit();
    }
  }
}
</script>

<style scoped>
</style>