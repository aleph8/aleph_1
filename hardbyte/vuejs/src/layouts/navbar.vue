
<template> 

<!--

Barra de navegación del invitado (usuario no registrado)

  Nos permite acceder a diversas páginas:
    ---- Home
    ---- About
    ---- Página de registro
    ---- Página de login

-->

  <div class="navbar">
    <section class="hero is-white">
      <div class="hero-body">
        <div class="container">
            <p  class="enlaces">
                
                <router-link onmouseout="this.style.color='#2c3e50'" onmouseover="this.style.color='red'" to="/">Home</router-link>  |
                <router-link onmouseout="this.style.color='#2c3e50'" onmouseover="this.style.color='red'" to="/about">About</router-link> |
                <router-link onmouseout="this.style.color='#2c3e50'" onmouseover="this.style.color='red'" to="/login">Login</router-link> |
                <router-link onmouseout="this.style.color='#2c3e50'" onmouseover="this.style.color='red'" to="/signup">SignUp</router-link>

            </p>
        </div>
      </div>
    </section>
  </div>
</template>
<script>
  export default {
    name: 'navbar',
    components: {
    },

  data() {
    return {
      event: "click"
    }
  },
  methods: {
  }

  };
</script>
<style lang="scss" scoped>
  .enlaces{
    font-weight: bold;
    color: #2c3e50;
    display: inline-block;
  }
  .hero {
    width: 200vh;
    background-color: aqua;
    text-align: center;
    background-size: cover;
    background-position: center;
    background-repeat: no-repeat;
  }

  .hero-body .title {
    font-size: 100px;
  }
  .is-xl {
    font-size: 1.7rem;
  }
</style>
