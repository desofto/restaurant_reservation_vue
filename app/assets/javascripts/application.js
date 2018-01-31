// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, or any plugin's
// vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file. JavaScript code in this file should be added after the last require_* statement.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require rails-ujs
//= require jquery3
//= require popper
//= require bootstrap
//= require jqBootstrapValidation
//= require jquery.easing
//= require_tree .
//= require vue/dist/vue.min
//= require vuex/dist/vuex.min
//= require vue-ls/dist/vue-ls.min
//= require vue-router/dist/vue-router.min
//= require vue-resource/dist/vue-resource.min
//qwe= require vue-stripe-checkout/dist/index

Vue.use(Vuex)
Vue.use(VueRouter)
Vue.use(VueResource)
Vue.use(VueLocalStorage, { namespace: 'restaurant_reservation' })

document.addEventListener('DOMContentLoaded', () => {
  Vue.http.headers.common['X-CSRF-Token'] = document.querySelector('meta[name="csrf-token"]').getAttribute('content')
})
