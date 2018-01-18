<template>
  <div>
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
      <div class="sidebar-item" @click="select('schedule')" :class="{ active: selected == 'schedule' }">
        Calendar
      </div>
      <div class="sidebar-item" @click="select('reservations')" :class="{ active: selected == 'reservations' }">
        Reservations
      </div>
      <div class="sidebar-item" @click="select('account')" :class="{ active: selected == 'account' }">
        Admin Account
      </div>
    </div>
    <div class="main">
      <schedule :user="user" v-if="selected == 'schedule'" />
      <reservations :user="user" v-if="selected == 'reservations'" />
      <account :user="user" v-if="selected == 'account'" />
    </div>
  </div>
</template>

<script>
  import Schedule from './schedule.vue'
  import Reservations from './reservations.vue'
  import Account from './account.vue'

  export default {
    props: {
      user: {
        type: Object,
        required: true
      }
    },

    data() {
      return {
        selected: 'account'
      }
    },

    methods: {
      logout() {
        this.$http.get('/api/v1/users/logout?token=' + this.user.token).then(response => {
          this.$emit('logout')
        }, (error) => {
          this.$emit('logout')
        })
      },

      select(item) {
        this.selected = item
      }
    },

    components: {
      schedule: Schedule,
      reservations: Reservations,
      account: Account
    }
  }
</script>

<style scoped>
  .header {
    background-color: #4a4a4a;
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

  .header .logout a {
    color: #d7d7d7;
  }

  .sidebar {
    padding-top: 4rem;
    height: 100vh;
    width: 20rem;
    float: left;
    background-color: #d7d7d7;
    color: #4a4a4a;
  }

  .sidebar .sidebar-item {
    cursor: pointer;
    margin-top: -2px;
    padding: 2rem;
    border: 2px solid #9a9a9a;
    color: #4a4a4a;
  }

  .sidebar .sidebar-item.active {
    background-color: #aaaaaa;
  }

  .sidebar .sidebar-item:hover {
    background-color: #cacaca;
  }

  .main {
    float: left;
  }
</style>
