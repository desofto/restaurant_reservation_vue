<template>
  <div class="admin">
    <div v-if="user && (user.role == 'admin' || user.role == 'operator')">
      <panel :user="user" @logout="logout()" />
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
      user: {
        type: Object,
        default: {}
      }
    },

    data() {
      return {
        user: this.$ls.get('user')
      }
    },

    methods: {
      setUser(user) {
        this.user = user
        this.$ls.set('user', this.user)
      },

      login(user) {
        this.setUser(user)
      },

      logout() {
        this.setUser('')
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
