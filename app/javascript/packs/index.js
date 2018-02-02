/* eslint no-console:0 */
// This file is automatically compiled by Webpack, along with any other files
// present in this directory. You're encouraged to place your actual application logic in
// a relevant structure within app/javascript and only use these pack files to reference
// that code so it'll be compiled.
//
// To reference this file, add <%= javascript_pack_tag 'application' %> to the appropriate
// layout file, like app/views/layouts/application.html.erb

document.addEventListener('DOMContentLoaded', () => {
  const app = new Vue({
    el: 'app',

    data() {
      return {
        scrollPosition: 0
      }
    },

    created() {
      window.addEventListener('scroll', this.scrolled)
    },

    destroyed() {
      window.removeEventListener('scroll', this.scrolled)
    },

    mounted() {
      this.scrolled()
    },

    methods: {
      scrollTo(id) {
        let target = document.querySelector(id)
        $('html, body').animate({
          scrollTop: target.offsetTop - 54
        }, 1000, "easeInOutExpo")
      },

      scrolled() {
        this.scrollPosition = window.scrollY
      }
    }
  })
})
