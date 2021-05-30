import {createRouter, createWebHistory} from "vue-router";
// import DCHeros from "./pages/DCHeros";
// import Calender from "./pages/Calender";
// import Home from "./pages/Home";
// import Markdown from "./pages/Markdown";
// import Slider from "./pages/Slider";
// import Calculator from "./pages/Calculator";
// import ReusableModal from "./pages/ReusableModal";
// import ChatApp from "./pages/ChatApp";

const DCHeros = ()=>import(/* webpackChunkName: "DCHeros" */ "./pages/DCHeros");
const Calender = ()=>import(/* webpackChunkName: "Calender" */"./pages/Calender");
const Home = ()=>import(/* webpackChunkName: "Home" */"./pages/Home");
const Markdown = ()=>import(/* webpackChunkName: "Markdown" */"./pages/Markdown");
const Slider = ()=>import(/* webpackChunkName: "Slider" */"./pages/Slider");
const Calculator = ()=>import(/* webpackChunkName: "Calculator" */"./pages/Calculator");
const ReusableModal = ()=>import(/* webpackChunkName: "ReusableModal" */"./pages/ReusableModal");
const ChatApp = ()=>import(/* webpackChunkName: "ChatApp" */"./pages/ChatApp");
import store from "./store/index"
const  UserList = ()=> import(/* webpackChunkName: "UserList" */"./pages/User/UserList");
const  Tensorflow = ()=> import(/* webpackChunkName: "Tensorflow" */"./pages/Tensorflow");

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
        // meta: { middleware: "auth" },
    },
    {
        path: '/chat-app',
        name: 'chat-app',
        component: ChatApp,
        meta: { middleware: "auth" },
        // beforeEnter: (to, from, next) => {
        //     if(store.state.isLoggedIn){
        //         next()
        //     }else{
        //         alert("Make sure you are logged in before using chat application.✌ ✌ ✌ ✌")
        //         next({name:"home"});
        //     }
        // }
    },
    {
        path: '/users',
        name: 'users',
        component: UserList,
    },
    {
        path: '/tensorflow',
        name: 'tensorflow',
        component: Tensorflow,
    },
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
