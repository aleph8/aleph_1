<template>
  <div id="app">
    <router-view/>
  </div>
</template>

<script>
  
   export default {
    name: 'App',
    components: {
      
    },
  };

</script>



<style lang="scss">

//Cambiamos el color de fondo al estilo de HardByte

#app {
  font-family: Avenir, Helvetica, Arial, sans-serif;
  -webkit-font-smoothing: antialiased;
  -moz-osx-font-smoothing: grayscale;
  text-align: center;
  color: #2c3e50;
}

nav {
  padding: 30px;

  a {
    font-weight: bold;
    color: #2c3e50;

    &.router-link-exact-active {
      color: #f00842;
    }
  }
}
</style>
