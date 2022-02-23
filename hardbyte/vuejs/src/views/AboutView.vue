
<!-- 

@author:Aleph8

Creamos una pequeña y simple vista  con una breve descripción de nuestro proyecto


-->
<template>
  <div class="about">
    <navbar> </navbar>
    <div class="hero is-dark">
      <div class="hero-body">
        <div class="container">
          <h1 class="title is-size-1 is-top">¿Qué es HardByte?</h1>
        </div>
      </div>
    </div>
    <div class="container">
      <p class="descripcion is-size-4">
        HardByte es una comunidad de especialistas es diversos temas unidos en proyectos comúnes, donde 
        cada uno aporta el conocimiento que domina, consiguiendo una sinergia entre todos sus participantes.
      </p>
      <p class="preguntaret is-size-3">
        ¿Qué gano uniéndome a HardByte?
      </p>
      <p class="descripcion is-size-4">
        En esta comunidad podrás desarrollar todos tus proyectos con la ayuda de múltiples profesionales, quienes
        facilitaran diversas tareas de proyectos multidisciplinares en aquellos campos que no domines. No solo esto,
        sino que siendo fieles a nuestra ética, todo el mundo aprende de una persona ya que cada persona puede aportar
        su granito de arena al conocimiento.
        
      </p>
    </div>
  </div>
</template>

<script>

  import navbar from '../layouts/navbar.vue'
  export default {
    name: 'about',
    components: {
      navbar
    },

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