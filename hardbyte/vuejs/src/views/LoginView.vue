<!-- 

@author:Aleph8

Página de Login


-->

 <template>


  <!--
    Inicio del formulario
  -->

  <form class="form" @submit.prevent="login" action="">
    
    <navbar> </navbar>
    
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
        <input  class="input is-rounded" type="password" v-model="form.password" required placeholder="Password">
      </p>
    </div>

  <!--
    boton que gestiona el el envío de la petición al backend
  -->
    <div class="field">
      <p class="control">
        <button class="button is-success is-rounded">
          Login
        </button>
      </p>
    </div>

  <!--
    Redirección a la página de registro
  -->
    <div class="field">
        <p class="link">
          ¿Aún no estás registrado? <router-link to="/signup" class="link"> ¡Regístrate! </router-link>
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
 import router from "../router";
 import navbar from '../layouts/navbar.vue'
 
 export default {
    name: 'Login',
    components: {
      navbar
    },

    data(){
      return{
        form: {
          username: '',
          password:''
        },
        errors: null
      }
    },


    methods: {

      /**
      * Metodo que gestiona el logueo en la página
      * la constante formada por el 'status' y 'data' estará formada por la respuesta del backend a la 
      * petición POST entrante con los parámetros que ha rellenado el usuario.
      *
      * En caso de estar el usuario registrado recibiremos un status='200' iniciando sesión
      * De lo contario recibiremos un status='422' que nos indica que algo está mal en los datos, tras consultar a la bd
      * 
      */

      async login(){
        
        console.log("login",this.form);

        try{

          const {status, data} = await axios.post('http://localhost:8080/log',this.form); //await para la ejecución asíncrona de login hasta recibir respuesta 
          console.log(status, data);

          //Guardamos la key de autenticación, lo que nos permite manejar y controlar la aplicación 
          //una vez que el usuario haya entrado.

          console.log(localStorage.getItem('AUTH_KEY'));
          localStorage.setItem('AUTH_KEY', data.auth_key);
          localStorage.setItem('NAME',data.username);
          localStorage.setItem('ID',data.id);
          localStorage.setItem('ADMIN',data.admin);
          console.log(localStorage.getItem('AUTH_KEY'));
          window.location.href="/user";


        } catch(e){
          this.errors = e.response.data.errors; //rellenamos los errores para mostrarlos al usuario por el frontend
          console.log(e);
        }

      }
    }


  };


</script>


<style lang="scss" scoped>

.errors{
  color: #f00842;
}

</style>