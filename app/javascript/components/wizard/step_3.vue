<template>
  <div class="form-inline">
    <h4>Your info</h4>

    <div class="group form-group">
      <div class="col-lg-6 col-md-12">
        <div class="group form-group" :class="{ 'has-error': errors.name }">
          <div class="col-md-6 col-xs-12 text-label">
            <label for="name" class="control-label">Name:</label>
          </div>
          <div class="col-md-6 col-xs-12">
            <input id="name" class="form-control" v-model="identification.name">
          </div>
        </div>
      </div>
      <div class="col-lg-6 col-md-12">
        <div class="group form-group" :class="{ 'has-error': errors.phone }">
          <div class="col-md-6 col-xs-12 text-label">
            <label for="phone" class="control-label">Phone number:</label>
          </div>
          <div class="col-md-6 col-xs-12">
            <input id="phone" class="form-control" v-model="identification.phone">
          </div>
        </div>
      </div>
    </div>

    <div class="group form-group">
      <div class="col-lg-6 col-md-12">
        <div class="group form-group" :class="{ 'has-error': errors.email }">
          <div class="col-md-6 col-xs-12 text-label">
            <label for="email" class="control-label">Email:</label>
          </div>
          <div class="col-md-6 col-xs-12">
            <input id="email" class="form-control" v-model="identification.email">
          </div>
        </div>
      </div>

      <div class="col-lg-6 col-md-12">
        <div class="group form-group" :class="{ 'has-error': errors.password }">
          <div class="col-md-6 col-xs-12 text-label">
            <label for="password" class="control-label">Password:</label>
          </div>
          <div class="col-md-6 col-xs-12">
            <input id="password" class="form-control" v-model="identification.password">
          </div>
        </div>
      </div>
    </div>

    <div class="group" style="display: inline-block; margin-top: 2rem;">
      <a>already has account?</a>
    </div>

    <button style="margin-top: 2rem;" class="btn btn-next text-uppercase" @click="checkForm()">
      Next
    </button>
  </div>
</template>

<script>
  export default {
    props: {
      identification: {
        type: Object,
        required: true
      }
    },
    data() {
      return {
        errors: {}
      }
    },
    methods: {
      checkForm() {
        this.errors = {};
        let hasError = false;
        if(this.identification.name.length < 1) this.errors.name = hasError = true;
        if(this.identification.phone.length < 1) this.errors.phone = hasError = true;
        if(this.identification.email.length < 1) this.errors.email = hasError = true;
        if(this.identification.password.length < 1) this.errors.password = hasError = true;
        if(hasError) return;
        this.$emit('next');
      }
    },
  }
</script>

<style scoped>
  .group {
    width: 100%;
    margin-top: 1rem;
  }

  .text-label {
    text-transform: uppercase;
  }

  @media (max-width: 767px) {
    .text-label {
      text-align: left;
    }
  }

  @media (min-width: 768px) {
    .text-label {
      text-align: left;
    }
  }

  @media (min-width: 992px) {
    .text-label {
      text-align: right;
    }
  }

  @media (min-width: 1200px) {
  }
</style>
