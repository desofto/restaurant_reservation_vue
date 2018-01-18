<template>
  <div class="schedule">
    <div class="panel panel-default table-bordered">
      <div class="panel-heading">Calendar</div>
      <table class="table table-bordered table-striped table-hover">
        <thead>
          <tr>
            <th>Date</th>
            <th>Total seat</th>
            <th>Available seat</th>
            <th>&nbsp;</th>
          </tr>
        </thead>
        <tbody>
          <tr v-for="(item, index) in schedule">
            <td>{{ item.date }}</td>
            <td>{{ item.count }}</td>
            <td>{{ item.free_seats }}</td>
            <td></td>
          </tr>
        </tbody>
      </table>
    </div>
  </div>
</template>

<script>
  export default {
    props: {
      token: {
        type: String,
        required: true
      }
    },

    data() {
      return {
        schedule: []
      }
    },

    mounted() {
      App.cable.subscriptions.create({ channel: 'ReservationsChannel', token: this.token }, {
        received: (data) => {
          this.load_schedule()
        }
      })

      this.load_schedule()
    },

    methods: {
      load_schedule() {
        this.$http.get('/api/v1/schedule?token=' + this.token).then(response => {
          this.schedule = response.body
        }, (error) => {
          this.error = error
        })
      }
    }
  }
</script>

<style scoped>
</style>
