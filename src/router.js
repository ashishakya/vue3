import {createRouter, createWebHistory} from "vue-router";

import store from "./store/index"
import userRoutes from "./routes/users";
import generalRoutes from "./routes/general";

const routes = [
    ...generalRoutes,
    ...userRoutes
];

const router = createRouter({
    routes,
    history:createWebHistory(),
    linkExactActiveClass: 'is-active',
});

router.beforeEach((to, from, next) => {
    if(to.meta.middleware){
        const middleware = require("./middlewares/auth.js");
        middleware.default(to, from, next, store);
    }else{
        next()
    }
})

export default router
