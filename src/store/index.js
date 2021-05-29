import { createStore } from 'vuex'

const store = createStore({
    state () {
        return {
            isLoggedIn:false,
            authUser:{}
        }
    },
    mutations: {
        setLoggedInStatus(state, status){
            state.isLoggedIn = status
        },
        setAuthUser(state, authUser){
            state.authUser = authUser
        }
    }
})

export default store

