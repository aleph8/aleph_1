

/**
 *  Imprescindible para el  enrutamiento esencial de nuestra aplicación.
 *  (Las vistas también son componentes)
 */

import { createRouter, createWebHistory } from 'vue-router'
import HomeView from '../views/HomeView.vue'
import HomeuserView from '../views/HomeuserView.vue'

const routes = [
  {
    path: '/',
    name: 'home',
    component: HomeView
  },
  {
    path: '/about',
    name: 'about',
    component: () => import(/* webpackChunkName: "about" */ '../views/AboutView.vue')
  },
  {
    //Creamos una nueva ruta para el path: '/login' con la vista Login que hemos creado
    path: '/login',
    name: 'login',

    component: () => import('../views/LoginView.vue')
  },
  {
    //Creamos una ruta para el registro del usuario
    path: '/signup',
    name: 'signup',

    component: () => import('../views/RegisterView.vue')
  },
  {
    //Creamos una ruta para el registro del usuario
    path: '/user',
    name: 'user',

    component: HomeuserView
  },
]

const router = createRouter({
  history: createWebHistory(process.env.BASE_URL),
  routes
})

//El siguiente método nos permite que podamos redirigir al usuario según nuestro inteŕes 

var key = localStorage.getItem('AUTH_KEY')

router.beforeEach((to, from, next) => {
  if(to.name == 'user' && ( key == null)){
    next({name: 'login'})
  }else  {
    next();
  }
});
  

export default router
