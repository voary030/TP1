import { createRouter, createWebHistory } from 'vue-router'
import { useAuthStore } from '../stores/auth'

const routes = [
  {
    path: '/login',
    name: 'Login',
    component: () => import('../views/LoginView.vue'),
    meta: { requiresAuth: false }
  },
  {
    path: '/',
    name: 'Home',
    redirect: '/semesters'
  },
  {
    path: '/semesters',
    name: 'Semesters',
    component: () => import('../views/SemestersView.vue'),
    meta: { requiresAuth: true }
  },
  {
    path: '/students',
    name: 'Students',
    component: () => import('../views/StudentsView.vue'),
    meta: { requiresAuth: true }
  },
  {
    path: '/students/:id',
    name: 'StudentDetail',
    component: () => import('../views/StudentDetailView.vue'),
    meta: { requiresAuth: true }
  },
  {
    path: '/students/:studentId/semester/4/select-parcours',
    name: 'ParcoursSelection',
    component: () => import('../views/ParcoursSelectionView.vue'),
    meta: { requiresAuth: true }
  },
  {
    path: '/students/:studentId/semester/:semesterId/parcours/:parcoursId',
    name: 'SemesterGradesWithParcours',
    component: () => import('../views/SemesterGradesView.vue'),
    meta: { requiresAuth: true }
  },
  {
    path: '/students/:studentId/semester/:semesterId',
    name: 'SemesterGrades',
    component: () => import('../views/SemesterGradesView.vue'),
    meta: { requiresAuth: true }
  },
  {
    path: '/students/:studentId/year/:yearLevel',
    name: 'YearGrades',
    component: () => import('../views/YearGradesView.vue'),
    meta: { requiresAuth: true }
  }
]

const router = createRouter({
  history: createWebHistory(import.meta.env.BASE_URL),
  routes
})

// Navigation guard
router.beforeEach((to, from, next) => {
  const authStore = useAuthStore()
  
  if (to.meta.requiresAuth && !authStore.isAuthenticated) {
    next('/login')
  } else if (to.path === '/login' && authStore.isAuthenticated) {
    next('/semesters')
  } else {
    next()
  }
})

export default router
