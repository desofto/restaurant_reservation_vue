/* eslint no-console:0 */
// This file is automatically compiled by Webpack, along with any other files
// present in this directory. You're encouraged to place your actual application logic in
// a relevant structure within app/javascript and only use these pack files to reference
// that code so it'll be compiled.
//
// To reference this file, add <%= javascript_pack_tag 'application' %> to the appropriate
// layout file, like app/views/layouts/application.html.erb

import Vue from 'vue/dist/vue.esm'
import Admin from '../components/admin/index.vue'

import VueResource from 'vue-resource'
Vue.use(VueResource)

import VueLocalStorage from 'vue-localstorage'
Vue.use(VueLocalStorage, { name: 'ls', bind: true })

document.addEventListener('DOMContentLoaded', () => {
  const app = new Vue({
    el: 'app',
    template: '<admin />',
    components: {
      admin: Admin
    }
  })
})
