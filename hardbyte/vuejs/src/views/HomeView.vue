<!--

@Author: Aleph

Vista home; será lo primero que vea el usuario al entrar a la página.

Cuenta con un título, un pequeño mensaje, y un botón formado por dos partes:

una de ella "el recipiente" y otra el botón como tal; el botón será pulsado para registrarse

Cuenta con diversos proyectos ficticios de prueba a lo largo de la página.


-->



<template> 

  <div class="home">

    <navbar> </navbar>

    <section class="hero is-dark">

      <div class="hero-body">

        <div class="container">

          <h1 class="title">¡Bienvenido a HardByte!</h1>

          <h2 class="subtitle is-size-3">

            ¡Únete a nuestra comunidad para crecer como profesional!
          </h2>

          <div class="button-form">

            <button @click="registro" class="button is-xl is-white">

              Empezar
              
            </button>


          </div>
        </div>
      </div>
    </section>
  </div>
</template>
<script>

  import navbar from '../layouts/navbar.vue'
  export default {
    name: 'home',
    components: {
      navbar,
    },
    methods: {
      registro () {
        window.location.href = "/signup"
      }
    }

  };
</script>
<style lang="scss" scoped>

  .hero {
    text-align: center;
    background-size: cover;
    background-position: center;
    background-repeat: no-repeat;
    height: 600px;
  }

  .hero-body .title {
    padding: 40px 0 70px 0;
    font-size: 60px;
  }

  .button-form {
    text-align: center;
    margin-left: auto;
    margin-right: auto;
    width: 100%;
    position: absolute;
    bottom: -170px;
    .button {
      margin-right: 50px;
      padding-left: 50px;
      padding-right: 50px;
    }
    .welcome {
      width: 400px;
      padding: 10px;
      margin-left: auto;
      margin-right: auto;
    }
  }
  .is-xl {
    font-size: 1.7rem;
  }
</style>