<template>
  <v-container>
    <p><strong>{{ countDown }}</strong> 秒キープ！</p>
    <video ref="video" width="500" height="500" autoplay class="mb-2 mt-2 mx-3"></video>
    <canvas ref="canvas" width="500" height="500" class="mb-2 mt-4 mx-3"></canvas>
    <v-row justify="center" class="mb-5">
      <v-btn class="mx-3" @click="shooting">Start</v-btn>
      <v-btn class="mx-3" @click="reset">Reset</v-btn>
      <v-btn class="mx-3">judgment</v-btn>
    </v-row>
  </v-container>
</template>

<script>

export default {
  name: 'Pose',
  data () {
    return {
      video: {},
      canvas: {},
      capture: [],
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
    shooting() {
      const takeCapture = function(inst){
        inst.canvas = inst.$refs.canvas
        // canvas.getContext('2d')でcanvasを2Dグラフィックを描画するためのメソッドやプロパティをもつオブジェクトにする
        // drawImageは<canvas> 要素の二次元文脈に於いて、任意の位置に任意の画像類を貼付けるメソッド
        inst.canvas.getContext('2d').drawImage(inst.video, 0, 60, 500, 380)
        inst.capture.push(inst.canvas.toDataURL('image/jpeg'))
      }
      const countDownTimer = function(inst){
        if(inst.countDown > 0) {
          inst.countDown -= 1
        }
      }
      let inst = this  // function関数内でthisを使用するために、変数instに代入
      setTimeout(function(){takeCapture(inst)}, 10000)
      this.timer = setInterval(function(){countDownTimer(inst)}, 1000)
    },
    reset() {
      this.countDown = 10
      clearInterval(this.timer)
      this.canvas.getContext('2d').clearRect(0, 0, 500, 500)
      //this.capture.length = 0
    },
    //submit() {
    //  const formData = new FormData()
    //  formData.append('pose[capture]', this.capture.pop)
    //  console.log(this.capture.pop)
    //  
    //  this.$axios.post('poses', formData)
    //  .then(res => {
    //    const pose = res.data.pose

    //    this.$router.push()
    //  })
    //}
  }
}
</script>

<style scoped>
</style>