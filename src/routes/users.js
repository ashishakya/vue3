const UserList = ()=>import(/* webpackChunkName: "UserList" */ "./../pages/User/UserList");

export default [
    {
        path: '/users',
        name: 'users',
        component: UserList,
    }
]
