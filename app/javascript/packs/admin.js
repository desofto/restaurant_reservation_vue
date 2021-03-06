/* eslint no-console:0 */
// This file is automatically compiled by Webpack, along with any other files
// present in this directory. You're encouraged to place your actual application logic in
// a relevant structure within app/javascript and only use these pack files to reference
// that code so it'll be compiled.
//
// To reference this file, add <%= javascript_pack_tag 'application' %> to the appropriate
// layout file, like app/views/layouts/application.html.erb

import Admin from '../components/admin/index.vue'

document.addEventListener('DOMContentLoaded', () => {
  const store = new Vuex.Store({
    state: {
      user: null
    },

    mutations: {
      login(state, user) {
        state.user = user
      },

      logout(state) {
        state.user = null
      }
    },

    actions: {
      authenticate(context) {
        return new Promise((resolve, reject) => {
          if(context.state.user) {
            resolve(context.state.user)
          } else {
            reject()
          }
        })
      }
    }
  })

  const app = new Vue({
    el: 'app',
    template: '<admin />',

    components: {
      admin: Admin
    },

    created() {
      this.$store.commit('login', this.$ls.get('user'))
    },

    store
  })
})
