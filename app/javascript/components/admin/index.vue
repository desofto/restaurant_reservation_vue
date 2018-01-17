<template>
  <div class="admin">
    <div v-if="token">
      <a href @click.prevent="logout()">Logout</a>
    </div>
    <div v-else>
      <login @login="login($event)" />
    </div>
  </div>
</template>

<script>
  import Login from './login.vue'

  export default {
    localStorage: {
      token: {
        type: String,
        default: ''
      }
    },

    data() {
      return {
        token: this.$ls.get('token')
      }
    },

    methods: {
      setToken(token) {
        this.token = token
        this.$ls.set('token', this.token)
      },

      login(token) {
        this.setToken(token)
      },

      logout() {
        this.setToken('')
      }
    },

    components: {
      login: Login
    }
  }
</script>

<style scoped>
</style>
