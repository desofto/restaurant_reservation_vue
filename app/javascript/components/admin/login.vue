<template>
  <div class="form-inline">
    <h4>Login</h4>

    <div v-if="errors.server" class="alert alert-warning">
      {{ errors.server }}
    </div>

    <div class="group form-group" :class="{ 'has-error': errors.email }">
      <div class="col-sm-6 col-xs-12 text-label">
        <label for="email" class="control-label">Email:</label>
      </div>
      <div class="col-sm-6 col-xs-12">
        <input id="email" class="form-control" v-model="email">
      </div>
    </div>

    <div class="group form-group" :class="{ 'has-error': errors.password }">
      <div class="col-sm-6 col-xs-12 text-label">
        <label for="password" class="control-label">Password:</label>
      </div>
      <div class="col-sm-6 col-xs-12">
        <input type="password" id="password" class="form-control" v-model="password">
      </div>
    </div>

    <button style="margin-top: 2rem;" class="btn btn-next text-uppercase" @click="login()">
      Login
    </button>
  </div>
</template>

<script>
  export default {
    data() {
      return {
        token: null,
        email: 'dmitry@desofto.com',
        password: 'QWEqwe123',
        errors: {
          email: false,
          password: false,
          server: false
        }
      }
    },

    methods: {
      login() {
        this.errors.server = false

        let hasError = false

        this.errors.email = this.email.length < 1
        hasError = hasError || this.errors.email

        this.errors.password = this.password.length < 1
        hasError = hasError || this.errors.password

        if(hasError) return

        let data = {
          email: this.email,
          password: this.password
        }

        this.$http.post('/api/v1/users', data).then(response => {
          if(['admin', 'operator'].includes(response.body.role)) {
            this.$emit('login', response.body.token)
          } else {
            this.error('Restricted area')
          }
        }, (error) => {
          this.error(error.body.errors)
        })
      },

      error(msg) {
        this.errors.server = msg

        setTimeout(() => {
          this.errors.server = false
        }, 2000)
      }
    },
  }
</script>

<style scoped>
  h4 {
    text-transform: uppercase;
    text-align: center;
    color: #f4a57c;
    font-weight: bold;
  }

  .form-inline {
    width: auto;
    height: 100%;
    padding-top: 1rem;
    text-align: center;
    max-width: 40rem;
    margin: auto;
  }

  .group {
    width: 100%;
    margin-top: 1rem;
    display: inline-block;
  }

  .text-label {
    text-transform: uppercase;
    text-align: left;
  }

  button.btn-next {
    border-radius: 1rem;
    padding: 1rem 0;
    border: 2px #9a9a9a solid;
    color: white;
    font-weight: bold;
    margin-top: 2rem;
    background-color: #a9a9a9;
    width: 22rem;
  }
</style>
