<!--

-->

<template>

<form class="form" @submit.prevent="signup" action="">

  <navbar> </navbar>

  <!--
    Campo de email
  -->
    <div class="field has-addons has-addons-centered">
      <p class="control">
        <input class="input is-rounded" type="text" v-model="form.email" required placeholder="E-mail">
      </p>
    </div>

  <!--
    Campo de username
  -->
    <div class="field has-addons has-addons-centered">
      <p class="control">
        <input class="input is-rounded" type="text" v-model="form.username" required placeholder="Username">
      </p>
    </div>

  <!--
    Campo de password
  -->
    <div class="field has-addons has-addons-centered">
      <p class="control">
        <input class="input is-rounded" type="text" v-model="form.password" required placeholder="Password">
      </p>
    </div>

  <!--
    Campo de especialist
  -->
    <div class="field has-addons has-addons-centered">
      <p class="control">
        <input class="input is-rounded" type="text" v-model="form.especialist" required placeholder="Especialist">
      </p>
    </div>

  <!--
    Campo de web URL
  -->
    <div class="field has-addons has-addons-centered">
      <p class="control">
        <input class="input is-rounded" type="text" v-model="form.web" placeholder="Web">
      </p>
    </div>

  <!--
    boton que gestiona el el envío de la petición al backend
  -->
    <div class="field">
      <p class="control">
        <button class="button is-success is-rounded">
          Signup
        </button>
      </p>
    </div>

  <!--
    Apartado que devuelve los errores recibidos al mandar una petición al backend 
    recibiendo el código de status '422' o 'entidad no procesable'
  -->
    <div v-if="errors" class="errors">
      <p v-for="(error, field) in errors" :key="field">
        {{error[0]}}
      </p>
    </div>


</form>

</template>

<script>

  
 import axios from 'axios';
 import navbar from '../layouts/navbar.vue'
 
 export default {
    name: 'Signup',
    components: {
      navbar
    },

    data(){
      return{
        form: {
          email: '',
          username:'',
          password:'',
          especialist:'',
          web:''
        },
        errors: null,
      }
    },


    methods: {

      /**
      * 
      * 
      */

      async signup(){
        
        console.log("signup",this.form);

        try{
          
          const {status, data} = await axios.post('http://localhost:8080/sig',this.form); //await para la ejecución asíncrona de signup hasta recibir respuesta 
          console.log(status, data);
          window.location.href= "/login";

        } catch(e){
          console.log(e.response.status);
          if(e.response.status == 500){ // Capturamos el error interno del servidor, producido por condiciones violadas de la base de datos. --\
            this.errors = [             //                                                                                                      \
              ["Usuario o email ya escogidos"] // <-------------------------------------error-------------------------atributos-'unique'---------\
            ];
          }else{
            this.errors = e.response.data.errors; //rellenamos los errores para mostrarlos al usuario por el frontend
          }
          console.log(e);
        }

      }
    }


  };

</script>

<style lang="css" scoped>

.errors{
  color: #f00842;
}

</style>