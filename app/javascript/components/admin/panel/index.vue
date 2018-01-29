<template>
  <div v-if="user">
    <div class="header">
      <div class="title">
        <strong>Reservation System</strong>
      </div>
      <div class="logout">
        <a href @click.prevent="logout()">Logout</a>
      </div>
      <div class="clearfix"></div>
    </div>
    <div class="sidebar">
      <router-link class="sidebar-item" :to="'/admin/schedule'">
        Calendar
      </router-link>
      <router-link class="sidebar-item" :to="'/admin/reservations'">
        Reservations
      </router-link>
      <router-link class="sidebar-item" :to="'/admin/account'">
        Admin Account
      </router-link>
    </div>
    <div class="main">
      <transition name="bounce" mode="out-in">
        <router-view :user="user"></router-view>
      </transition>
    </div>
  </div>
</template>

<script>
  import Schedule from './schedule.vue'
  import Reservations from './reservations.vue'
  import Account from './account.vue'

  import VueRouter from 'vue-router'

  const routes = [
    { path: '/admin',               redirect: '/admin/schedule' },
    { path: '/admin/schedule',      component: Schedule },
    { path: '/admin/reservations',  component: Reservations },
    { path: '/admin/account',       component: Account }
  ]

  const router = new VueRouter({
    routes,
    mode: 'history'
  })

  export default {
    props: {
      user: {
        type: Object
      }
    },

    methods: {
      logout() {
        this.$http.get('/api/v1/users/logout?token=' + this.user.token).then(response => {
          this.$emit('logout')
        }, (error) => {
          this.$emit('logout')
        })
      }
    },

    components: {
      schedule: Schedule,
      reservations: Reservations,
      account: Account
    },

    router
  }
</script>

<style scoped>
  .header {
    background-color: #212529;
    color: #d7d7d7;
    width: 100%;
    padding: 1rem;
  }

  .header .title {
    float: left;
  }

  .header .logout {
    float: right;
    margin-right: 3rem;
  }

  .sidebar {
    float: left;
    background-color: #212529;
    color: #4a4a4a;
    width: 100%;
    text-align: center;
  }

  .sidebar .sidebar-item {
    padding: 0.5rem;
    cursor: pointer;
    border: 2px solid #212529;
    color: white;
    float: left;
    margin-left: -2px;
  }

  .sidebar .sidebar-item.router-link-active {
    background-color: #fec810d9;
  }

  .sidebar .sidebar-item:hover {
    background-color: #fec810;
  }

  .main {
    padding: 1rem;
  }

  @media (max-width: 767px) {
  }

  @media (min-width: 768px) {
  }

  @media (min-width: 992px) {
    .sidebar {
      width: 20rem;
      height: 100vh;
    }

    .sidebar .sidebar-item {
      margin-top: -2px;
      margin-left: auto;
      padding: 2rem;
      width: 100%;
    }

    .main {
      margin-left: 20rem;
    }
  }

  @media (min-width: 1200px) {
  }

  .bounce-enter {
  }

  .bounce-enter-active {
    animation: bounce-in .5s;
  }

  .bounce-enter-to {
  }

  .bounce-leave {
    display: none;
  }

  .bounce-leave-active {
    animation: bounce-out .2s;
  }

  .bounce-leave-to {
  }

  @keyframes bounce-in {
    0% {
      transform: scale(0);
    }
    50% {
      transform: scale(1.1);
    }
    100% {
      transform: scale(1);
    }
  }

  @keyframes bounce-out {
    0% {
      transform: scale(1);
    }
    50% {
      transform: scale(0.5);
    }
    100% {
      transform: scale(0);
    }
  }
</style>
