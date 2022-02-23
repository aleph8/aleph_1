
<!-- 

@author:Aleph8

Creamos una pequeña y simple vista  con una breve descripción de nuestro proyecto


-->
<template>
  <div class="error">
    <div class="hero is-dark">
      <div class="hero-body">
        <div class="container">
          <h1 class="title is-size-1 is-top">ERROR: PAGE NOT FOUND</h1>
        </div>
      </div>
    </div>
  </div>
</template>
<script>
 export default {
    name: 'error',
    components: {},
  };
</script>


<style lang="scss" scoped>

.descripcion {
  margin-top: 50px;
}

.preguntaret{
  margin-top: 30px;
  letter-spacing: 5px;
  color: #f00842;
}

.is-top{
  margin-top: 80px;
}

.hero-body{
 margin-bottom: 80px;
}

</style>