<template>
  <div class="admin">
    <div v-if="token">
      <panel :token="token" @logout="logout()" />
    </div>
    <div v-else>
      <login @login="login($event)" />
    </div>
  </div>
</template>

<script>
  import Login from './login.vue'
  import Panel from './panel/index.vue'

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
      login: Login,
      panel: Panel
    }
  }
</script>

<style scoped>
</style>
