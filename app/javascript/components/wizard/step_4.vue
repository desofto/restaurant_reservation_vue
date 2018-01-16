<template>
  <div class="form-inline">
    <h4>Your info</h4>

    <div class="group">
      <div class="col-sm-6 col-xs-12 text-label">
        <label class="control-label">Guests:</label>
      </div>
      <div class="col-sm-6 col-xs-12 text-uppercase">
        {{ reservation.guests }} person
      </div>
    </div>

    <div class="group">
      <div class="col-sm-6 col-xs-12 text-label">
        <label class="control-label">Date:</label>
      </div>
      <div class="col-sm-6 col-xs-12 text-uppercase">
        {{ reservationDate() }}
      </div>
    </div>

    <div class="group">
      <div class="col-sm-6 col-xs-12 text-label">
        <label class="control-label">Name:</label>
      </div>
      <div class="col-sm-6 col-xs-12">
        {{ identification.name }}
      </div>
    </div>

    <div class="group">
      <div class="col-sm-6 col-xs-12 text-label">
        <label class="control-label">Phone number:</label>
      </div>
      <div class="col-sm-6 col-xs-12">
        {{ identification.phone }}
      </div>
    </div>

    <div class="group">
      <div class="col-sm-6 col-xs-12 text-label">
        <label class="control-label">Email:</label>
      </div>
      <div class="col-sm-6 col-xs-12">
        {{ identification.email }}
      </div>
    </div>

    <form style="margin-top: 2rem;">
      <stripe-checkout
        stripe-key="pk_test_EAj5BTkLoiJS3DWC3O6M4q78"
        product="product"
        button="Continue to pay free -&gt;"
        button-class="btn btn-next text-uppercase"
        locale="auto"
        :email="identification.email"
        on-success="broadcast">
      </stripe-checkout>
    </form>
  </div>
</template>

<script>
  import { StripeCheckout } from 'vue-stripe';
  import { Bus } from 'vue-stripe';

  export default {
    props: {
      reservation: {
        type: Object,
        required: true
      },
      identification: {
        type: Object,
        required: true
      }
    },

    data() {
      return {
      }
    },

    mounted() {
      Bus.$on('vue-stripe.success', payload => {
        // payload.email, payload.token
        let data = {
          reservation: {
            guests: this.reservation.guests,
            date: {
              year: this.reservation.date.year,
              month: this.reservation.date.month,
              day: this.reservation.date.day,
              hour: this.reservation.date.hour
            }
          },
          identification: {
            name: this.identification.name,
            phone: this.identification.phone,
            email: this.identification.email,
            password: this.identification.password
          },
          token: payload.token
        }
        this.$http.post('/api/v1/reservations', data).then(response => {
          alert('paid');
        });
      });
    },

    calculated: {
      product() {
        return {
          name: "A table reservation",
          description: "A table for " + this.reservation.guests + " person on " + this.reservationDate(),
          amount: 100
        }
      },
    },

    methods: {
      reservationDate() {
        return (new Date(this.reservation.date.year, this.reservation.date.month-1, this.reservation.date.day)).toLocaleString("en-us", { year: "numeric", month: "long", day: "2-digit" });
      }
    },

    components: {
      'stripe-checkout': StripeCheckout
    }
  }
</script>

<style scoped>
  .group {
    width: 100%;
    margin-top: 1rem;
    display: inline-block;
  }

  .text-label {
    text-transform: uppercase;
    text-align: left;
  }
</style>
