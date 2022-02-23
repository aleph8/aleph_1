<template>
<!--

Vista del usuario una vez se registra; al pulsar logout, todos la información almacenada en el almacenamiento local será
eliminada y el usuario será redirigido al componente no registrado "HomeView.vue"

-->
    <section class="hero is-dark">
      <usernavbar> </usernavbar>
      <div class="hero-body">

        <div class="container">

          <h1 class="title">¡Bienvenido a HardByte!</h1>

          <h2 class="subtitle is-size-3">

           Mantenimiento

          </h2>

          <div class="button-form">

            <button @click="logout" class="button is-xl is-white">

              Logout
              
            </button>


          </div>
        </div>
      </div>
    </section>
</template>

<script>
   import usernavbar from '../layouts/usernavbar.vue'
   export default {
    name: 'HomeUser',
    components: {
      usernavbar
    },

    data(){
    return {
      event: "click"
    }
    },


    methods: {
      logout(){
          console.log(localStorage.getItem('AUTH_KEY'));
          localStorage.removeItem('AUTH_KEY');
          localStorage.removeItem('ID');
          localStorage.removeItem('ADMIN');
          localStorage.removeItem('NAME');
          window.location.href="/";
      }
    }


  };

</script>

<style>

</style>
