import Vue from 'vue';
import VueRouter from 'vue-router';
import Home from '../components/Home.vue';
import BookingIndexPage from '../components/bookings/BookingIndexPage.vue';
import BookingDetailPage from '../components/bookings/BookingDetailPage.vue';
import BookingNew from '../components/bookings/BookingNew.vue';
import PetIndexPage from '../components/pets/PetIndexPage.vue';
import PetDetailPage from '../components/pets/PetDetailPage.vue';
import PetDetailEdit from '../components/pets/PetDetailEdit.vue';
import PetNew from '../components/pets/PetNew.vue';
import MenuIndexPage from '../components/menus/MenuIndexPage.vue';


Vue.use(VueRouter)

export default new VueRouter({
  mode: 'history',
  base: process.env.BASE_URL,
  routes: [
    { path: '/',
      component: Home },
    { path: '/employees/bookings/',
      component: BookingIndexPage },
    { path: '/employees/bookings/:id(\\d+)',
      name: 'BookingDetailPage',
      component: BookingDetailPage },
    { path: '/employees/bookings/new/',
      name: 'BookingNew',
      component: BookingNew },

    { path: '/employees/charts/',
      component: PetIndexPage },
    { path: '/employees/charts/:id(\\d+)',
      name: 'PetDetailPage',
      component: PetDetailPage },
      { path: '/employees/charts/edit/:id(\\d+)',
      name: 'PetDetailEdit',
      component: PetDetailEdit },
      { path: '/employees/charts/new/',
      name: 'PetNew',
      component: PetNew },
      { path: '/employees/settings/',
      component: MenuIndexPage },
  ]
})



