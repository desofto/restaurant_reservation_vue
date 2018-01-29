/* eslint no-console:0 */
// This file is automatically compiled by Webpack, along with any other files
// present in this directory. You're encouraged to place your actual application logic in
// a relevant structure within app/javascript and only use these pack files to reference
// that code so it'll be compiled.
//
// To reference this file, add <%= javascript_pack_tag 'application' %> to the appropriate
// layout file, like app/views/layouts/application.html.erb

import Vue from 'vue/dist/vue.esm'

import Vuex from 'vuex'
Vue.use(Vuex)

import VueResource from 'vue-resource'
Vue.use(VueResource)

import Wizard from '../components/wizard/index.vue'

document.addEventListener('DOMContentLoaded', () => {
  Vue.http.headers.common['X-CSRF-Token'] = document.querySelector('meta[name="csrf-token"]').getAttribute('content')

  const store = new Vuex.Store({
    modules: {
      reservation: {
        namespaced: true,

        state: {
          guests: 2,
          seats: 0,
          date: {
            year: (new Date).getFullYear(),
            month: (new Date).getMonth() + 1,
            day: (new Date).getDate(),
            hour: null //12
          }
        },

        mutations: {
          guests(state, count) {
            state.guests = count
          },

          seats(state, count) {
            state.seats = count
          },

          date(state, date) {
            state.date = date
          }
        }
      },

      identification: {
        namespaced: true,

        state: {
          name: '', //'John Smith',
          phone: '', //'+1234567890',
          email: '', //'test@gmail.com',
          password: ''//'qweQWE123'
        },

        mutations: {
          name(state, value) {
            state.name = value
          },

          phone(state, value) {
            state.phone = value
          },

          email(state, value) {
            state.email = value
          },

          password(state, value) {
            state.password = value
          }
        }
      }
    }
  })

  const app = new Vue({
    el: 'app',
    template: '<wizard />',

    components: {
      wizard: Wizard
    },

    store
  })
})
