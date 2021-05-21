import {createRouter, createWebHistory} from "vue-router";
import DCHeros from "./Pages/DCHeros";
import Calender from "./Pages/Calender";
import Home from "./Pages/Home";


const routes = [
    {
        path: '/',
        name: 'home',
        component: Home,
    },
    {
        path: '/dc-heros',
        name: 'dcheros',
        component: DCHeros,
    },
    {
        path: '/calender',
        name: 'calender',
        component: Calender,
    },
];

const router = createRouter({
    routes,
    history:createWebHistory()
});

export default router
