import {createRouter, createWebHistory} from "vue-router";
import DCHeros from "./Pages/DCHeros";
import Calender from "./Pages/Calender";
import Home from "./Pages/Home";
import Markdown from "./Pages/Markdown";
import Slider from "./Pages/Slider";
import Calculator from "./Pages/Calculator";
import ReusableModal from "./Pages/ReusableModal";
import ChatApp from "./Pages/ChatApp";

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
    {
        path: '/markdown',
        name: 'markdown',
        component: Markdown,
    },
    {
        path: '/slider',
        name: 'slider',
        component: Slider,
    },
    {
        path: '/calculator',
        name: 'calculator',
        component: Calculator,
    },
    {
        path: '/reusable-modal',
        name: 'reusable-modal',
        component: ReusableModal,
    },
    {
        path: '/chat-app',
        name: 'chat-app',
        component: ChatApp,
    },
];

const router = createRouter({
    routes,
    history:createWebHistory()
});

export default router
