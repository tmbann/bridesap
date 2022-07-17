<template>
  <v-container>
    <p><strong>{{ countDown }}</strong>秒キープ！</p>
    <video ref="video" width="300" height="200" autoplay></video>
    <canvas ref="canvas" width="300" height="200"></canvas>
    <v-btn @click="shooting">撮影開始</v-btn>
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
      countDown: 10
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
        inst.canvas.getContext('2d').drawImage(inst.video, 0, 0, 300, 200)
        inst.capture.push(inst.canvas.toDataURL('image/jpeg'))
      }
      const countDownTimer = function(inst){
        if(inst.countDown > 0) {
          inst.countDown -= 1
        }
      }
      let inst = this
      setTimeout(function(){takeCapture(inst)}, 10000)
      setInterval(function(){countDownTimer(inst)}, 1000)

      //const formData = new FormData()
      //formData.append('pose[capture]', this.capture)
      
      //this.$axios.post('poses', formData)
      //.then(res => {
      //  const pose = res.data.pose

      //  this.$router.push()
      //})
    },
  },
}
</script>

<style scoped>
</style>