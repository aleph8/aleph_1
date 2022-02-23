<template> 
<!--
 Barra de navegación de usuario una vez éste inicia sesión.

 Dependiendo del rol que cumplas en la web tendrás disponible ciertos privilegios (para esto nos ayudamos de la renderización condicional):
      ----- Adminuistrador : puede acceder a gestión en el backend, siendo redirigido automáticamente
      ----- Usuario Normal : permiso estándar
      
 Controlamos el acceso usuario/administrador con el token almacenado en el localStorage ('ADMIN')
-->
  <div class="usernavbar">
    <section class="hero is-white">
      <div class="hero-body">
        <div class="container">
            <div class="enlaces">
                <label v-if="ad === 'S'"> {{ad}} </label> ¡Bienvenido   {{ nom }} ! | 
                <router-link onmouseout="this.style.color='#2c3e50'" onmouseover="this.style.color='red'" to="/user">Home</router-link>
                <label class="admin" @click = "adminback" v-if="ad === 'S'" > Administración </label>
            </div>
        </div>
      </div>
    </section>
  </div>
</template>
<script>
  export default {
    name: 'usernavbar',
    components: {
    },

  data() {
    return {
      nom : localStorage.getItem('NAME'),
      ad: localStorage.getItem('ADMIN')
    }
  },
  methods: {
    adminback (){
      window.open('http://localhost:8080/admin','_blank')
    }
  }

  };
</script>
<style lang="scss" scoped>
  .enlaces{
    font-weight: bold;
    color: #2c3e50;
    margin-right: 50px;
  }
  .admin{
    color: red;
    border-radius: 100px;
    float: right;
  }
  .container{
    background-size: cover;
  }
  .hero {
    width: 200vh;
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
