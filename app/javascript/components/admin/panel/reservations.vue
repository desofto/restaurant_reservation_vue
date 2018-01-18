<template>
  <div>
    reservations
  </div>
</template>

<script>
  export default {
    props: {
      token: {
        type: String,
        required: true
      }
    },

    data() {
      return {
        reservations: []
      }
    },

    mounted() {
      this.$http.get('/api/v1/reservations?token=' + this.token).then(response => {

      }, (error) => {
        this.error = error
      })
    }
  }
</script>

<style scoped>
</style>
